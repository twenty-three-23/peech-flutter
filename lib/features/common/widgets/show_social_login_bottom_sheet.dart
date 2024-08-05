import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/social_login_controller.dart';
import 'package:swm_peech_flutter/features/common/models/login_view_state.dart';

void showSocialLoginBottomSheet(BuildContext context) {

  SocialLoginCtr controller = Get.put(SocialLoginCtr());
  if(controller.isShowed == true) return;
  controller.isShowed = true;

  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: Center(
          child: GetX<SocialLoginCtr>(
            builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  '3초 간편 로그인 후 계속하기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                if(controller.loginState == LoginViewState.waitingToLogin)
                  Column(
                    children: [
                      const Text(
                        '지금 로그인하면 매달 150분 무료 사용 가능!',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if(controller.isLoginFailed.value == true)
                        const Column(
                          children: [
                            Text(
                              '로그인에 실패했습니다. 다시 시도해주세요.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        )
                      else
                        const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          controller.loginWithKakao(context);
                        },
                        child: Image.asset('assets/images/kakao_login_medium_wide.png'),
                      ),
                    ],
                  )
                else if(controller.loginState == LoginViewState.success)
                  const Text(
                      '로그인 성공!',
                      style: TextStyle(
                        fontSize: 15,
                      )
                  )
                else if(controller.loginState == LoginViewState.loading)
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    Get.delete<SocialLoginCtr>();
  });
}