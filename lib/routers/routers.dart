import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/home/controller/home_controller.dart';
import 'package:swm_peech_flutter/features/mypage/controller/mypage_controller.dart';
import 'package:swm_peech_flutter/features/mypage/view/mypage_screen.dart';
import 'package:swm_peech_flutter/features/onboarding/controller/onboarding_controller.dart';
import 'package:swm_peech_flutter/features/onboarding/view/onboarding_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_detail.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_major_detail_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_view.dart';
import 'package:swm_peech_flutter/features/practice_result/controller/practice_result_controller.dart';
import 'package:swm_peech_flutter/features/practice_result/view/practice_result_screen.dart';
import 'package:swm_peech_flutter/features/root/view/root_screen.dart';
import 'package:swm_peech_flutter/features/script_input/controller/script_input_controller.dart';
import 'package:swm_peech_flutter/features/script_input/view/script_expected_time_screen.dart';
import 'package:swm_peech_flutter/features/script_input/view/script_input_screen.dart';
import 'package:swm_peech_flutter/features/theme_input/controller/theme_input_controller.dart';
import 'package:swm_peech_flutter/features/theme_input/view/theme_input_screen.dart';
import 'package:swm_peech_flutter/features/voice_recode/controller/voice_recode_controller.dart';
import 'package:swm_peech_flutter/features/voice_recode/view/voice_recode_screen_no_script.dart';
import 'package:swm_peech_flutter/features/voice_recode/view/voice_recode_screen_with_script.dart';

import '../features/interview_question/controller/interview_question_input_controller.dart';
import '../features/interview_question/view/interview_question_input_screen.dart';
import '../features/interview_question/view/interview_question_result_screen.dart';

import '../features/home/view/home_screen2.dart';

class Routers {
  static const INITIAL = '/root';

  static final routers = [
    GetPage(
      name: '/onboarding',
      page: () => OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/root',
      page: () => RootScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeCtr>(() => HomeCtr());
        Get.lazyPut<HistoryCtr>(() => HistoryCtr());
        Get.lazyPut<MyPageController>(() => MyPageController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/home',
      page: () => const HomeScreen2(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeCtr>(() => HomeCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/scriptInput/input',
      page: () => const ScriptInputScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ScriptInputCtr>(() => ScriptInputCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/scriptInput/result',
      page: () => const ScriptExpectedTimeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ScriptInputCtr>(() => ScriptInputCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/voiceRecodeNoScript',
      page: () => const VoiceRecodeScreenNoScript(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VoiceRecodeCtr>(() => VoiceRecodeCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/voiceRecodeWithScript',
      page: () => const VoiceRecodeScreenWithScript(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VoiceRecodeCtr>(() => VoiceRecodeCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/themeInput',
      page: () => const ThemeInputScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ThemeInputCtr>(() => ThemeInputCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/historyThemeList',
      page: () => const HistoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HistoryCtr>(() => HistoryCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/historyMajorDetail',
      page: () => const HistoryMajorDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HistoryCtr>(() => HistoryCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/practiceResult',
      page: () => const PracticeResultScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PracticeResultCtr>(() => PracticeResultCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/mypage',
      page: () => const MyPageScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MyPageController>(() => MyPageController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/interviewQuestions',
      page: () => const InterviewQuestionInputScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<InterviewQuestionInputController>(
          () => InterviewQuestionInputController(),
        );
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/interviewQuestionsResult',
      page: () => const InterviewQuestionResultScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<InterviewQuestionInputController>(
          () => InterviewQuestionInputController(),
        );
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/defaultScripts',
      page: () => const HistoryView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HistoryCtr>(() => HistoryCtr());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/historyDetail',
      page: () => const HistoryDetail(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HistoryCtr>(() => HistoryCtr());
      }),
      transition: Transition.noTransition,
    ),
  ];
}
