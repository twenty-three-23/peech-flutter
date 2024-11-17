import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_social_login_data_souce.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_additional_info_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/events/social_login_bottom_sheet_open_event.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_model.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_response_model.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_info.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_choice_view_state.dart';
import 'package:swm_peech_flutter/features/common/models/user_additional_info_model.dart';
import 'package:swm_peech_flutter/features/common/models/user_additional_info_view_state.dart';
import 'package:swm_peech_flutter/features/common/models/user_gender.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_funnel/platform_funnel.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
import 'package:swm_peech_flutter/firebase_messaging/firebase_messaging_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/constants.dart';
import '../data_source/local/local_practice_theme_storage.dart';

class SocialLoginCtr extends GetxController {
  bool isShowed = false;
  Rx<SocialLoginChoiceViewState> loginChoiceViewState = Rx<SocialLoginChoiceViewState>(SocialLoginChoiceViewState.waitingToLogin);
  Rx<bool> loginChoiceViewLoginFailed = Rx<bool>(false);
  Rx<SocialLoginBottomSheetState> socialLoginBottomSheetState = Rx<SocialLoginBottomSheetState>(SocialLoginBottomSheetState.choiceView);
  Rx<String> firstName = Rx<String>('default');
  Rx<String> lastName = Rx<String>('default');
  Rx<DateTime?> birthday = Rx<DateTime?>(null);
  Rx<UserGender> gender = Rx<UserGender>(UserGender.unknown);
  Rx<String> nickname = Rx<String>('');
  Rx<UserAdditionalInfoViewState> userAdditionalInfoViewState = Rx<UserAdditionalInfoViewState>(UserAdditionalInfoViewState.input);
  Rx<bool> userAdditionalInfoViewLoginFailed = Rx<bool>(false);

  RxBool checkPrivacyAgreement = false.obs;

  bool checkDefaultThemeId = false;

  final userInfoController = Get.find<UserInfoController>();

  void loginWithKakao(BuildContext context) async {
    if (checkPrivacyPolicyAgreement(context) == false) return; // 개인정보 처리방침 체크 확인
    loginChoiceViewState.value = SocialLoginChoiceViewState.loading;
    if (await isKakaoTalkInstalled() && !Platform.isIOS) {
      try {
        //카카오톡으로 로그인
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print("KAKAO AccessToken: ${token.accessToken}");

        //서버로 전송
        SocialLoginInfo kakaoLoginInfo = SocialLoginInfo(socialToken: token.accessToken, authorizationServer: 'KAKAO');
        AuthTokenResponseModel authTokenResponseModel = await postSocialToken(kakaoLoginInfo);

        //화면 상태 변경
        loginChoiceViewState.value = SocialLoginChoiceViewState.success;
        loginChoiceViewLoginFailed.value = false;
        print('카카오톡으로 로그인 성공');

        loginFinish(); // 로그인 성공시 호출하는 함수

        //추가 정보 입력 분기
        await Future.delayed(const Duration(milliseconds: 500));
        if (authTokenResponseModel.statusCode == 411) {
          // 추가 정보 입력 화면으로 이동
          AppEventBus.instance.fire(SocialLoginBottomSheetOpenEvent(
              socialLoginBottomSheetState: SocialLoginBottomSheetState.gettingAdditionalDataView, fromWhere: 'postSocialToken'));
        } else {
          // 로그인 성공
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("카카오톡 로그인 성공!"),
          ));
          // 바텀 시트 닫기
          if (context.mounted) {
            Navigator.pop(context);
          }
          userInfoController.getUserAudioTimeInfo(); //홈 화면 오디오 시간 받아오기
        }
      } on DioException catch (error) {
        // 서버 에러
        loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
        loginChoiceViewLoginFailed.value = true;
        print('카카오톡으로 로그인 실패(dio exception) $error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("카카오톡 로그인 실패: 서버 에러"),
        ));
        rethrow;
      } catch (error) {
        // 클라이언트 에러
        loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin; // 로그인 선택 뷰로 상태 변경
        loginChoiceViewLoginFailed.value = true; // 로그인 실패 표시 보이기
        print('카카오톡으로 로그인 실패(exception) $error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("카카오톡 로그인 실패: 클라이언트 에러"),
        ));
        rethrow;
      }
    } else {
      print('카카오톡이 깔려있지 않거나 IOS입니다. 웹뷰로 로그인을 시도합니다.');

      //카카오 계정으로 로그인
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print("KAKAO AccessToken: ${token.accessToken}");

      //서버로 전송
      SocialLoginInfo kakaoLoginInfo = SocialLoginInfo(socialToken: token.accessToken, authorizationServer: 'KAKAO');
      AuthTokenResponseModel authTokenResponseModel = await postSocialToken(kakaoLoginInfo);

      //화면 상태 변경
      loginChoiceViewState.value = SocialLoginChoiceViewState.success;
      loginChoiceViewLoginFailed.value = false;
      print('카카오톡으로 로그인 성공');

      loginFinish(); // 로그인 성공시 호출하는 함수

      //추가 정보 입력 분기
      await Future.delayed(const Duration(milliseconds: 500));
      if (authTokenResponseModel.statusCode == 411) {
        // 추가 입력 화면으로 이동
        AppEventBus.instance.fire(
            SocialLoginBottomSheetOpenEvent(socialLoginBottomSheetState: SocialLoginBottomSheetState.gettingAdditionalDataView, fromWhere: 'postSocialToken'));
      } else {
        // 로그인 성공
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("카카오톡 로그인 성공!"),
        ));
        // 바텀 시트 닫기
        if (context.mounted) {
          Navigator.pop(context);
        }
        userInfoController.getUserAudioTimeInfo(); // 홈 화면 오디오 시간 받아오기
      }
    }
  }

  void loginWithApple(BuildContext context) async {
    if (checkPrivacyPolicyAgreement(context) == false) return; // 개인정보 처리방침 체크 확인
    loginChoiceViewState.value = SocialLoginChoiceViewState.loading;
    try {
      //apple id login
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'swm-peech-flutter.twenty-three.com',
          redirectUri: Uri.parse('https://twenty-three-4d6f6.firebaseapp.com/__/auth/handler'),
        ),
      );

      print('[credential]: $credential');
      print('credential.state = $credential');
      print('credential.email = ${credential.email}');
      print('credential.userIdentifier = ${credential.userIdentifier}');
      print('credential.identityToken = ${credential.identityToken}');

      //서버로 전송
      SocialLoginInfo appleLoginInfo = SocialLoginInfo(socialToken: credential.identityToken, authorizationServer: 'APPLE');
      AuthTokenResponseModel authTokenResponseModel = await postSocialToken(appleLoginInfo);
      loginChoiceViewState.value = SocialLoginChoiceViewState.success;
      loginChoiceViewLoginFailed.value = false;
      print('apple id로 로그인 성공');

      loginFinish(); // 로그인 성공시 호출하는 함수

      // 추가정보 입력 분기
      await Future.delayed(const Duration(milliseconds: 500));
      if (authTokenResponseModel.statusCode == 411) {
        // 추가정보 입력 화면으로 이동
        AppEventBus.instance.fire(
            SocialLoginBottomSheetOpenEvent(socialLoginBottomSheetState: SocialLoginBottomSheetState.gettingAdditionalDataView, fromWhere: 'postSocialToken'));
      } else {
        // 로그인 성공
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("애플 로그인 성공!"),
        ));
        // 바텀 시트 닫기
        if (context.mounted) {
          Navigator.pop(context);
        }
        userInfoController.getUserAudioTimeInfo(); // 홈 화면 오디오 시간 받아오기
      }
    } on DioException catch (error) {
      loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
      loginChoiceViewLoginFailed.value = true;
      print('Apple Id로 로그인 실패(dio exception): $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("애플 로그인 실패: 서버 에러"),
        ),
      );
      rethrow;
    } catch (error) {
      loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
      loginChoiceViewLoginFailed.value = true;
      print('Apple Id로 로그인 실패(exception) $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("애플 로그인 실패: 클라이언트 에러"),
        ),
      );
      rethrow;
    }
  }

  Future<AuthTokenResponseModel> postSocialToken(SocialLoginInfo kakaoLoginInfo) async {
    RemoteSocialLoginDataSource remoteSocialLoginDataSource = RemoteSocialLoginDataSource(AuthDioFactory().dio);
    String funnel = PlatformFunnel.getFunnel();
    print('funnel: $funnel');
    AuthTokenResponseModel authTokenResponseModel = await remoteSocialLoginDataSource.postSocialToken(
      funnel,
      kakaoLoginInfo.toJson(),
    );
    await saveUserToken(authTokenResponseModel.responseBody ?? AuthTokenModel());
    return authTokenResponseModel;
  }

  Future<void> saveUserToken(AuthTokenModel authTokenModel) async {
    LocalAuthTokenStorage localAuthTokenStorage = LocalAuthTokenStorage();
    print('accessToken 저장 -> ${authTokenModel.accessToken}');
    print('refreshToken 저장 -> ${authTokenModel.refreshToken}');
    localAuthTokenStorage.setAccessToken(authTokenModel.accessToken ?? "");
    localAuthTokenStorage.setRefreshToken(authTokenModel.refreshToken ?? "");
  }

  void additionInfoConfirmBtn(BuildContext context) async {
    userAdditionalInfoViewState.value = UserAdditionalInfoViewState.loading;
    if (firstName.value.isEmpty || lastName.value.isEmpty || nickname.value.isEmpty) {
      userAdditionalInfoViewState.value = UserAdditionalInfoViewState.input;
      userAdditionalInfoViewLoginFailed.value = true;
      return;
    }
    try {
      UserAdditionalInfoModel userAdditionalInfoModel = UserAdditionalInfoModel(
          firstName: firstName.value,
          lastName: lastName.value,
          birth: formatDate(birthday.value ?? DateTime(1900, 0, 0)),
          gender: formatGender(gender.value),
          nickName: nickname.value);
      RemoteUserAdditionalInfoDataSource remoteUserAdditionalInfoDataSource = RemoteUserAdditionalInfoDataSource(AuthDioFactory().dio);
      String funnel = PlatformFunnel.getFunnel();
      print('funnel: $funnel');
      AuthTokenModel authTokenModel = await remoteUserAdditionalInfoDataSource.postUserAdditionalInfo(funnel, userAdditionalInfoModel.toJson());
      await saveUserToken(authTokenModel);
      //추가정보 입력 성공
      if (context.mounted) {
        Navigator.pop(context);
      }
      userInfoController.getUserAudioTimeInfo();
    } on DioException catch (e) {
      print("[additionInfoConfirmBtn] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch (e) {
      print("[additionInfoConfirmBtn] [Exception] $e");
      rethrow;
    } finally {
      userAdditionalInfoViewState.value = UserAdditionalInfoViewState.input;
    }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  String formatGender(UserGender gender) {
    switch (gender) {
      case UserGender.male:
        return 'MALE';
      case UserGender.female:
        return 'FEMALE';
      case UserGender.unknown:
        return 'UNKNOWN';
    }
  }

  void initialViewState() {
    userAdditionalInfoViewState.value = UserAdditionalInfoViewState.input;
    loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
    loginChoiceViewLoginFailed.value = false;
    userAdditionalInfoViewLoginFailed.value = false;
  }

  void gotoPrivacyPolicy() async {
    Uri privacyPolicyUri = Uri.parse(Constants.privacyPolicyUrl);

    if (await canLaunchUrl(privacyPolicyUri)) {
      await launchUrl(privacyPolicyUri, mode: LaunchMode.inAppWebView);
    } else {
      throw '[gotoPrivacyPolicy] Could not launch $privacyPolicyUri';
    }
  }

  bool checkPrivacyPolicyAgreement(BuildContext context) {
    if (checkPrivacyAgreement.value == false) {
      showCommonDialog(
        context: context,
        title: '개인정보처리방침',
        message: "개인정보 처리에 동의해주세요.",
        showFirstButton: false,
        secondButtonText: '확인',
        isSecondButtonToClose: true,
      );
    }
    return checkPrivacyAgreement.value;
  }

  void loginFinish() {
    print('[loginFinish]');
    FirebaseMessagingManager.putFcmToken();
  }
}
