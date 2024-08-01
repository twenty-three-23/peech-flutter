import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void showSocialLoginBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                '간편 로그인 후 계속하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                  '지금 로그인하면 매달 150분 무료 사용 가능!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  if (await isKakaoTalkInstalled()) {
                    try {
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                        content: Text("카카오톡 로그인 성공!"),
                      ));
                      Navigator.pop(context);
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("로그인 실패 $error"),
                      ));
                    }
                  } else {
                    print('카카오톡이 깔려있지 않습니다.');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("카카오톡이 깔려있지 않습니다"),
                    ));
                  }
                },
                child: Image.asset('assets/images/kakao_login_medium_wide.png'),
              )
            ],
          ),
        ),
      );
    },
  );
}

void kakaoLogin() async {
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  } else {
    print('카카오톡이 깔려있지 않습니다.');
  }
}