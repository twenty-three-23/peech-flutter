import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/home/view/home_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/theme_list_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/view/theme_list_screen.dart';
import 'package:swm_peech_flutter/features/script_input/controller/script_input_controller.dart';
import 'package:swm_peech_flutter/features/script_input/view/script_input_screen.dart';
import 'package:swm_peech_flutter/features/theme_input/controller/theme_input_controller.dart';
import 'package:swm_peech_flutter/features/theme_input/view/theme_input_screen.dart';
import 'package:swm_peech_flutter/features/voice_recode/controller/voice_recode_controller.dart';
import 'package:swm_peech_flutter/features/voice_recode/view/voice_recode_screen_no_script.dart';
import 'package:swm_peech_flutter/features/voice_recode/view/voice_recode_screen_with_script.dart';

class Routers {

  static const INITIAL = '/home';

  static final routers = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen()
    ),
    GetPage(
      name: '/scriptInput',
      page: () => const ScriptInputScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ScriptInputCtr>(() => ScriptInputCtr());
      })
    ),
    GetPage(
        name: '/voiceRecodeNoScript',
        page: () => const VoiceRecodeScreenNoScript(),
        binding: BindingsBuilder(() {
          Get.lazyPut<VoiceRecodeCtr>(() => VoiceRecodeCtr());
        })
    ),
    GetPage(
        name: '/voiceRecodeWithScript',
        page: () => const VoiceRecodeScreenWithScript(),
        binding: BindingsBuilder(() {
          Get.lazyPut<VoiceRecodeCtr>(() => VoiceRecodeCtr());
        })
    ),
  GetPage(
      name: '/themeInput',
      page: () => const ThemeInputScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ThemeInputCtr>(() => ThemeInputCtr());
      })
    ),
    GetPage(
      name: '/historyThemeList',
      page: () => const ThemeListScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ThemeListCtr>(() => ThemeListCtr());
      })
    )
  ];

}