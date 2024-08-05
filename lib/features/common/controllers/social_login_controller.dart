import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_social_login_data_souce.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/events/social_login_bottom_sheet_open_event.dart';
import 'package:swm_peech_flutter/features/common/models/login_token_model.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_info.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_choice_view_state.dart';

class SocialLoginCtr extends GetxController {

  bool isShowed = false;
  Rx<SocialLoginChoiceViewState> loginState = Rx<SocialLoginChoiceViewState>(SocialLoginChoiceViewState.waitingToLogin);
  Rx<bool> isLoginFailed = Rx<bool>(false);
  Rx<SocialLoginBottomSheetState> socialLoginBottomSheetState = Rx<SocialLoginBottomSheetState>(SocialLoginBottomSheetState.choiceView);

  void loginWithKakao(BuildContext context) async {
    loginState.value = SocialLoginChoiceViewState.loading;
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print("토큰: ${token.accessToken}");
        SocialLoginInfo kakaoLoginInfo = SocialLoginInfo(socialToken: token.accessToken, authorizationServer: 'KAKAO');
        await postUserToken(kakaoLoginInfo);
        loginState.value = SocialLoginChoiceViewState.success;
        isLoginFailed.value = false;
        print('카카오톡으로 로그인 성공');
        await Future.delayed(const Duration(milliseconds: 500));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("카카오톡 로그인 성공!"),
            ));
        if(context.mounted) {
          Navigator.pop(context);
        }
      } on DioException catch (error) {

        if(error.response?.statusCode == 411) {
          loginState.value = SocialLoginChoiceViewState.success;
          isLoginFailed.value = false;
          print('카카오톡으로 로그인 성공');
          await Future.delayed(const Duration(milliseconds: 500));
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("카카오톡 로그인 성공!"),
              ));
          AppEventBus.instance.fire(SocialLoginBottomSheetOpenEvent(socialLoginBottomSheetState: SocialLoginBottomSheetState.gettingAdditionalDataView));
          return;
        }

        loginState.value = SocialLoginChoiceViewState.waitingToLogin;
        isLoginFailed.value = true;
        print('카카오톡으로 로그인 실패 $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 실패 $error"),
        ));
        rethrow;
      } catch (error) {
        loginState.value = SocialLoginChoiceViewState.waitingToLogin;
        isLoginFailed.value = true;
        print('카카오톡으로 로그인 실패 $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 실패 $error"),
        ));
        rethrow;
      }
    } else {
      loginState.value = SocialLoginChoiceViewState.waitingToLogin;
      print('카카오톡이 깔려있지 않습니다.');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("카카오톡이 깔려있지 않습니다"),
      ));
    }
  }

  Future<void> postUserToken(SocialLoginInfo kakaoLoginInfo) async {
    RemoteSocialLoginDataSource remoteSocialLoginDataSource = RemoteSocialLoginDataSource(AuthDioFactory().dio);
    LoginTokenModel loginTokenModel = await remoteSocialLoginDataSource.postSocialToken(kakaoLoginInfo.toJson());
    LocalAuthTokenStorage localAuthTokenStorage = LocalAuthTokenStorage();
    localAuthTokenStorage.setAccessToken(loginTokenModel.accessToken ?? "");
    localAuthTokenStorage.setRefreshToken(loginTokenModel.refreshToken ?? "");
  }
}