import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_social_login_data_souce.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/login_token_model.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_info.dart';
import 'package:swm_peech_flutter/features/common/models/login_view_state.dart';

class SocialLoginCtr extends GetxController {

  Rx<LoginViewState> loginState = Rx<LoginViewState>(LoginViewState.waitingToLogin);
  Rx<bool> isLoginFailed = Rx<bool>(false);

  void loginWithKakao(BuildContext context) async {
    loginState.value = LoginViewState.loading;
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print("토큰: ${token.accessToken}");
        SocialLoginInfo kakaoLoginInfo = SocialLoginInfo(socialToken: token.accessToken, authorizationServer: 'KAKAO');
        RemoteSocialLoginDataSource remoteSocialLoginDataSource = RemoteSocialLoginDataSource(AuthDioFactory().dio);
        LoginTokenModel loginTokenModel = await remoteSocialLoginDataSource.postSocialToken(kakaoLoginInfo.toJson());
        print(loginTokenModel);
        loginState.value = LoginViewState.success;
        isLoginFailed.value = false;
        print('카카오톡으로 로그인 성공');
        await Future.delayed(Duration(milliseconds: 500));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("카카오톡 로그인 성공!"),
            ));
        if(context.mounted) {
          Navigator.pop(context);
        }
      } on DioException catch (error) {
        loginState.value = LoginViewState.waitingToLogin;
        isLoginFailed.value = true;
        print('카카오톡으로 로그인 실패 $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 실패 $error"),
        ));
        rethrow;
      } catch (error) {
        loginState.value = LoginViewState.waitingToLogin;
        isLoginFailed.value = true;
        print('카카오톡으로 로그인 실패 $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 실패 $error"),
        ));
        rethrow;
      }
    } else {
      loginState.value = LoginViewState.waitingToLogin;
      print('카카오톡이 깔려있지 않습니다.');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("카카오톡이 깔려있지 않습니다"),
      ));
    }
  }
}