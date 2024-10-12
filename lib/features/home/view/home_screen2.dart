import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';

import '../../common/controllers/social_login_controller.dart';
import '../../common/data_source/local/local_practice_mode_storage.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});


  @override
  Widget build(BuildContext context) {

    var controller = Get.put(SocialLoginCtr());

    return CommonScaffold(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(children: [
        SizedBox(height: 8),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              "발표 대본을 입력하고 \n함께 연습을 시작해볼까요?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3B3E43),
              ),
            ),
          ),
        ),
        Spacer(),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                // 그림자 색상 및 투명도 (25% 투명도)
                spreadRadius: 1,
                // 그림자 확산 반경
                blurRadius: 5, // 그림자 흐림 정도r
              ),
            ],
          ),
          child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/interviewQuestions");
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 152),
                side: BorderSide(color: const Color(0xffE5E8F0), width: 1.0),
                // 테두리 색상과 두께 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 모서리 둥글기 설정
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/interview_question.png', width: 120, height: 120),
                  Column(
                    children: [
                      Text(
                        "예상 면접질문 받기",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: const Color(0xff3B3E43),
                        ),
                      ),
                      Text(
                        "자기소개 입력하고 확인해보기!",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffFF5468),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      // 그림자 색상 및 투명도 (25% 투명도)
                      spreadRadius: 1,
                      // 그림자 확산 반경
                      blurRadius: 5, // 그림자 흐림 정도
                    ),
                  ],
                ),
                child: OutlinedButton(
                    onPressed: () {
                      LocalPracticeModeStorage().setMode(PracticeMode.noScript);
                      controller.saveDefaultTheme();
                      Navigator.pushNamed(context, "/voiceRecodeNoScript");
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(148, 164),
                      side: BorderSide(
                          color: const Color(0xffE5E8F0),
                          width: 1.0), // 테두리 색상과 두께 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // 모서리 둥글기 설정
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/mike.png', width: 100, height: 100),
                          Column(
                            children: [
                              Text(
                                "속도 분석 받기",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: const Color(0xff3B3E43),
                                ),
                              ),
                              Text(
                                "녹음하고 분석 받기",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff6D6F78),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      // 그림자 색상 및 투명도 (25% 투명도)
                      spreadRadius: 1,
                      // 그림자 확산 반경
                      blurRadius: 5, // 그림자 흐림 정도
                    ),
                  ],
                ),
                child: OutlinedButton(
                    onPressed: () {
                      controller.saveDefaultTheme();
                      Navigator.pushNamed(context, '/scriptInput/input');
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(148, 164),
                      side: BorderSide(
                          color: const Color(0xffE5E8F0),
                          width: 1.0), // 테두리 색상과 두께 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // 모서리 둥글기 설정
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/clock.png', width: 100, height: 100),
                          Column(
                            children: [
                              Text(
                                "예상 시간 받기",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: const Color(0xff3B3E43),
                                ),
                              ),
                              Text(
                                "대본 입력하고 확인하기",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff6D6F78),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 22,
        )
      ]),
    ));
  }
}
