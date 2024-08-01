import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:swm_peech_flutter/features/common/models/login_view_state.dart';

class SocialLoginCtr extends GetxController {

  Rx<LoginViewState> loginState = Rx<LoginViewState>(LoginViewState.waitingToLogin);

  void loginWithKakao(BuildContext context) async {
    loginState.value = LoginViewState.loading;
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        loginState.value = LoginViewState.success;
        print('카카오톡으로 로그인 성공');
        await Future.delayed(Duration(milliseconds: 500));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("카카오톡 로그인 성공!"),
            ));
        if(context.mounted) {
          Navigator.pop(context);
        }
      } catch (error) {
        loginState.value = LoginViewState.waitingToLogin;
        print('카카오톡으로 로그인 실패 $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("로그인 실패 $error"),
        ));
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