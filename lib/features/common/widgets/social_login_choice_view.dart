import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:swm_peech_flutter/features/common/controllers/social_login_controller.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_choice_view_state.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_device_info/platform_device_info.dart';
import 'package:swm_peech_flutter/features/mypage/controller/mypage_controller.dart';

Widget socialLoginChoiceView(BuildContext context, SocialLoginCtr controller) {
  return Container(
    color: Colors.white,
    child: SizedBox(
      height: 350,
      child: Center(
        child: Column(
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
            if (controller.loginChoiceViewState.value == SocialLoginChoiceViewState.waitingToLogin)
              Column(
                children: [
                  const Text(
                    '지금 로그인하면 매달 150분 사용 가능!',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const Text(
                    '(유료 결제 없음)',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Checkbox(
                          value: controller.checkPrivacyAgreement.value,
                          onChanged: (bool? value) {
                            controller.checkPrivacyAgreement.value = value!;
                          })),
                      GestureDetector(
                        onTap: () {
                          controller.checkPrivacyAgreement.value = !controller.checkPrivacyAgreement.value;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.gotoPrivacyPolicy();
                            },
                            child: Text(
                              "개인정보 처리방침 및 이용약관에 동의합니다.",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (controller.loginChoiceViewLoginFailed.value == true)
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
                    onTap: () {
                      controller.loginWithKakao(context);
                    },
                    child: Image.asset(
                      'assets/images/kakao_login_medium_wide.png',
                    ),
                  ),
                  if (PlatformDeviceInfo.isIOS())
                    Column(
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: SignInWithAppleButton(
                            onPressed: () {
                              controller.loginWithApple(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  // SignInWithAppleButton(
                  //   onPressed: () async {
                  //     final AppleAuthProvider provider = AppleAuthProvider();
                  //     provider.addScope('email');
                  //     provider.addScope('name');
                  //     final UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(provider);
                  //     print('userCredential: ${userCredential.user?.getIdToken()}');
                  //   },
                  // ),
                ],
              )
            else if (controller.loginChoiceViewState.value == SocialLoginChoiceViewState.success)
              const Text('로그인 성공!',
                  style: TextStyle(
                    fontSize: 15,
                  ))
            else if (controller.loginChoiceViewState.value == SocialLoginChoiceViewState.loading)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    ),
  );
}
