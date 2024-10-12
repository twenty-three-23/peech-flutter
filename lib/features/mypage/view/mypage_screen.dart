import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/home/view/home_screen.dart';
import 'package:swm_peech_flutter/features/mypage/controller/mypage_controller.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<MyPageController>();

    UserInfoController userInfoController = Get.find<UserInfoController>();
    MyPageController myPageController = Get.find<MyPageController>();

    userInfoController.fetchUserNickname();
    userInfoController.getUserAudioTimeInfo();

    return CommonScaffold(
      child: ListView(padding: const EdgeInsets.fromLTRB(24, 0, 24, 0), children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Container(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() => Text('${userInfoController.userNickname ?? "GUEST"}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700))),
                    Text(
                      "의 연습기록입니다.",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    )
                  ],
                )),
            SizedBox(height: 24),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(color: Color(0xFFF4F6FA), borderRadius: BorderRadius.circular(16)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetX<UserInfoController>(
                          builder: (_) => Text('총 ${userInfoController.remainingTime?.text ?? "?"} 사용 가능',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
                      IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            userInfoController.getUserAudioTimeInfo();
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: GetX<UserInfoController>(
                      builder: (_) => Text(
                            '1회 최대 ${userInfoController.maxAudioTime?.text ?? "?"}분 연습 가능',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          )),
                )
              ]),
            ),
            SizedBox(height: 60),
            Column(children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text("공지사항", style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43), fontWeight: FontWeight.w400)),
                    onPressed: () {
                      myPageController.gotoAnnouncement();
                    },
                  ),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        myPageController.gotoAnnouncement();
                      })
                ],
              )),
              SizedBox(height: 24),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(child: Text("문의하기", style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43), fontWeight: FontWeight.w400)), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () {})
                ],
              )),
              SizedBox(height: 24),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text("이용 방법", style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43), fontWeight: FontWeight.w400)),
                      onPressed: () {
                        myPageController.gotoUsageGuide();
                      }),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        myPageController.gotoUsageGuide();
                      })
                ],
              )),
              SizedBox(height: 24),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text("개인정보 처리방침", style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43), fontWeight: FontWeight.w400)),
                      onPressed: () {
                        myPageController.gotoPrivacyPolicy();
                      }),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        myPageController.gotoPrivacyPolicy();
                      })
                ],
              )),
            ]),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {
                      myPageController.logOutButton(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF4F6FA)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  child: TextButton(
                    onPressed: () {
                      myPageController.deleteUserButton(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: Text(
                        '회원 탈퇴',
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF4F6FA)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(180, 10, 180, 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Color(0xFFF4F6FA)),
                child: Text(
                  "앱 버전 1.0.0",
                  style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43), fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
