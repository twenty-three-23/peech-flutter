import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/review_controller.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/mypage/controller/mypage_controller.dart';
import 'package:swm_peech_flutter/features/mypage/widget/app_version_button.dart';
import 'package:swm_peech_flutter/features/mypage/widget/mypage_item_button.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  UserInfoController userInfoController = Get.find<UserInfoController>();
  MyPageController myPageController = Get.find<MyPageController>();
  ReviewController reviewController = Get.find<ReviewController>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBarTitle: '마이페이지',
      hideBackButton: true,
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
                    Obx(
                      () => Text(
                        '${userInfoController.userNickname ?? "GUEST"}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 34 / 22,
                        ),
                      ),
                    ),
                    Text(
                      "의 연습기록입니다.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 26 / 18,
                      ),
                    )
                  ],
                )),
            SizedBox(height: 8),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(color: Color(0xFFF4F6FA), borderRadius: BorderRadius.circular(16)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetX<UserInfoController>(
                        builder: (_) => Text(
                          '총 ${userInfoController.remainingTime?.text ?? "?"} 사용 가능',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 26 / 18,
                          ),
                        ),
                      ),
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
                            '1회 최대 ${userInfoController.maxAudioTime?.text ?? "?"} 연습 가능',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 22 / 14,
                            ),
                          )),
                )
              ]),
            ),
            SizedBox(height: 48),
            Column(
              children: [
                MypageItemButton(
                  text: '공지사항',
                  onTap: () {
                    myPageController.gotoAnnouncement();
                  },
                ),
                MypageItemButton(
                  text: '문의하기',
                  onTap: () {
                    reviewController.reviewRequired(context: context);
                  },
                ),
                MypageItemButton(
                  text: '이용 방법',
                  onTap: () {
                    myPageController.gotoUsageGuide();
                  },
                ),
                MypageItemButton(
                  text: '개인정보 처리방침',
                  onTap: () {
                    myPageController.gotoPrivacyPolicy();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 65,
                  height: 34,
                  child: TextButton(
                    onPressed: () {
                      myPageController.logOutButton(context);
                    },
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 22 / 14,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF4F6FA)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 65,
                  height: 34,
                  child: TextButton(
                    onPressed: () {
                      myPageController.deleteUserButton(context);
                    },
                    child: Text(
                      '회원 탈퇴',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 22 / 14,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF4F6FA)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            AppVersionButton(),
          ],
        ),
      ]),
    );
  }
}
