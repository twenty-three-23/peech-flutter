import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/app_info_controller.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';
import 'package:swm_peech_flutter/features/common/widgets/primary_color_button.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_social_login_bottom_sheet.dart';
import 'package:swm_peech_flutter/features/home/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final appInfoController = Get.find<AppInfoController>();
  final controller = Get.find<HomeCtr>();
  final userInfoController = Get.find<UserInfoController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appInfoController.checkAppInfo(context);
    });
  }

  @override
    Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const SizedBox(height: 15.5,),
            SvgPicture.asset(
                'assets/images/app_bar_logo.svg',
                semanticsLabel: 'peech app bar logo'
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 112.5,),
            const Text(
              "발표 대본을 작성하면\n가장 적절한 시간을 계산해줘요!\n함께 연습을 시작해 볼까요?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30,),
            GetX<HomeCtr>(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 40,),
                  Column(
                    children: [
                      GetX<UserInfoController>(
                        builder: (_) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("총"),
                            const SizedBox(width: 3,),
                            userInfoController.remainingTime.value == null
                                ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2,))
                                : Text(
                                    userInfoController.remainingTime.value?.text ?? "?",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )
                                  ),
                            const SizedBox(width: 3,),
                            const Text("사용 가능"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("1회 최대"),
                          const SizedBox(width: 3,),
                            userInfoController.maxAudioTime.value == null
                              ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2,))
                              : Text(
                                  userInfoController.maxAudioTime.value?.text ?? "?",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                          const SizedBox(width: 3,),
                          const Text("연습 가능"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                        onPressed: () { userInfoController.getUserAudioTimeInfo(); },
                        icon: const Icon(Icons.refresh, size: 17,)
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ColoredButton(
                    onPressed: () {
                        Navigator.pushNamed(context, '/themeInput');
                      },
                    text: "연습 시작하기",
                    backgroundColor: const Color(0xFF3B3E43),
                    textColor: const Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: ColoredButton(
                    onPressed: () { Navigator.pushNamed(context, '/historyThemeList'); },
                    text:"기록 보기",
                    backgroundColor: const Color(0xFF3B3E43),
                    textColor: const Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            TextButton(
                onPressed: () {
                  controller.contactToEmail(context);
                },
                child: const Text(
                    "이메일로 문의하기",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3B3E43),
                      height: 22 / 14,
                    )
                )
            ),
            TextButton(onPressed: () { showSocialLoginBottomSheet(context, SocialLoginBottomSheetState.choiceView); }, child: const Text("소셜 로그인")),
            TextButton(onPressed: () { controller.kakaoUnlink(); }, child: const Text("회원탈퇴")),
            TextButton(onPressed: () { controller.logOut(); }, child: const Text("로그아웃")),
            const SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
}
