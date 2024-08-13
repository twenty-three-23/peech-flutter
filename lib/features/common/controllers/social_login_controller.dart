import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
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

class SocialLoginCtr extends GetxController {

  bool isShowed = false;
  Rx<SocialLoginChoiceViewState> loginChoiceViewState = Rx<SocialLoginChoiceViewState>(SocialLoginChoiceViewState.waitingToLogin);
  Rx<bool> loginChoiceViewLoginFailed = Rx<bool>(false);
  Rx<SocialLoginBottomSheetState> socialLoginBottomSheetState = Rx<SocialLoginBottomSheetState>(SocialLoginBottomSheetState.choiceView);
  Rx<String> firstName = Rx<String>('');
  Rx<String> lastName = Rx<String>('');
  Rx<DateTime> birthday = Rx<DateTime>(DateTime(2000, 1, 1));
  Rx<UserGender> gender = Rx<UserGender>(UserGender.unknown);
  Rx<String> nickname = Rx<String>('');
  Rx<UserAdditionalInfoViewState> userAdditionalInfoViewState = Rx<UserAdditionalInfoViewState>(UserAdditionalInfoViewState.input);
  Rx<bool> userAdditionalInfoViewLoginFailed = Rx<bool>(false);


  void loginWithKakao(BuildContext context) async {
    loginChoiceViewState.value = SocialLoginChoiceViewState.loading;
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print("토큰: ${token.accessToken}");
        SocialLoginInfo kakaoLoginInfo = SocialLoginInfo(socialToken: token.accessToken, authorizationServer: 'KAKAO');
        AuthTokenResponseModel authTokenResponseModel = await postSocialToken(kakaoLoginInfo);
        loginChoiceViewState.value = SocialLoginChoiceViewState.success;
        loginChoiceViewLoginFailed.value = false;
        print('카카오톡으로 로그인 성공');
        await Future.delayed(const Duration(milliseconds: 500));
        if(authTokenResponseModel.statusCode == 411) {
          AppEventBus.instance.fire(SocialLoginBottomSheetOpenEvent(socialLoginBottomSheetState: SocialLoginBottomSheetState.gettingAdditionalDataView, fromWhere: 'postSocialToken'));
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("카카오톡 로그인 성공!"),
              ));
          if(context.mounted) {
            Navigator.pop(context);
          }
        }
      } on DioException catch (error) {

        loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
        loginChoiceViewLoginFailed.value = true;
        print('카카오톡으로 로그인 실패(dio exception) $error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("카카오톡 로그인 실패: 서버 에러"),
        ));
        rethrow;
      } catch (error) {
        loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
        loginChoiceViewLoginFailed.value = true;
        print('카카오톡으로 로그인 실패(exception) $error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("카카오톡 로그인 실패: 클라이언트 에러"),
        ));
        rethrow;
      }
    } else {
      loginChoiceViewState.value = SocialLoginChoiceViewState.waitingToLogin;
      print('카카오톡이 깔려있지 않습니다.');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("카카오톡이 깔려있지 않습니다"),
      ));
    }
  }

  Future<AuthTokenResponseModel> postSocialToken(SocialLoginInfo kakaoLoginInfo) async {
    RemoteSocialLoginDataSource remoteSocialLoginDataSource = RemoteSocialLoginDataSource(AuthDioFactory().dio);
    AuthTokenResponseModel authTokenResponseModel = await remoteSocialLoginDataSource.postSocialToken(kakaoLoginInfo.toJson());
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
    if(firstName.value.isEmpty || lastName.value.isEmpty || nickname.value.isEmpty) {
      userAdditionalInfoViewState.value = UserAdditionalInfoViewState.input;
      userAdditionalInfoViewLoginFailed.value = true;
      return;
    }
    try {
      UserAdditionalInfoModel userAdditionalInfoModel = UserAdditionalInfoModel(
          firstName: firstName.value,
          lastName: lastName.value,
          birth: formatDate(birthday.value),
          gender: formatGender(gender.value),
          nickName: nickname.value
      );
      RemoteUserAdditionalInfoDataSource remoteUserAdditionalInfoDataSource = RemoteUserAdditionalInfoDataSource(AuthDioFactory().dio);
      AuthTokenModel authTokenModel = await remoteUserAdditionalInfoDataSource.postUserAdditionalInfo(userAdditionalInfoModel.toJson());
      await saveUserToken(authTokenModel);
      if(context.mounted) {
        Navigator.pop(context);
      }
    } on DioException catch(e) {
      print("[additionInfoConfirmBtn] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
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
    switch(gender) {
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
}