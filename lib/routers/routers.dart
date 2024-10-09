import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/home/controller/home_controller.dart';
import 'package:swm_peech_flutter/features/home/view/home_screen.dart';
import 'package:swm_peech_flutter/features/interview_question/view/interview_question_result_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_major_detail_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_screen.dart';
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

class Routers {
  static const INITIAL = '/root';

  static final routers = [
    GetPage(name: '/root', page: () => RootScreen(), transition: Transition.noTransition),
    GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<HomeCtr>(() => HomeCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/scriptInput/input',
        page: () => const ScriptInputScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ScriptInputCtr>(() => ScriptInputCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/scriptInput/result',
        page: () => const ScriptExpectedTimeScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ScriptInputCtr>(() => ScriptInputCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/voiceRecodeNoScript',
        page: () => const VoiceRecodeScreenNoScript(),
        binding: BindingsBuilder(() {
          Get.lazyPut<VoiceRecodeCtr>(() => VoiceRecodeCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/voiceRecodeWithScript',
        page: () => const VoiceRecodeScreenWithScript(),
        binding: BindingsBuilder(() {
          Get.lazyPut<VoiceRecodeCtr>(() => VoiceRecodeCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/themeInput',
        page: () => const ThemeInputScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ThemeInputCtr>(() => ThemeInputCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/historyThemeList',
        page: () => const HistoryScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<HistoryCtr>(() => HistoryCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/historyMajorDetail',
        page: () => const HistoryMajorDetailScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<HistoryCtr>(() => HistoryCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/practiceResult',
        page: () => const PracticeResultScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<PracticeResultCtr>(() => PracticeResultCtr());
        }),
        transition: Transition.noTransition),
    GetPage(
        name: '/interviewQuestions',
        page: () => const InterviewQuestionInputScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<InterviewQuestionInputController>(() => InterviewQuestionInputController());
        }),),
    GetPage(
      name: '/interviewQuestionsResult',
      page: () => const InterviewQuestionResultScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<InterviewQuestionInputController>(() => InterviewQuestionInputController());
      }),),
  ];
}
