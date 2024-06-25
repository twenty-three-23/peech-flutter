import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/home/view/homeScreen.dart';
import 'package:swm_peech_flutter/features/scriptInput/controller/script_input_controller.dart';
import 'package:swm_peech_flutter/features/scriptInput/view/script_input_screen.dart';
import 'package:swm_peech_flutter/features/themeInput/view/theme_input_screen.dart';
import 'package:swm_peech_flutter/features/voiceRecode/controller/voice_recode_controller.dart';
import 'package:swm_peech_flutter/features/voiceRecode/view/voice_recode_screen_no_script.dart';
import 'package:swm_peech_flutter/features/voiceRecode/view/voice_recode_screen_with_script.dart';

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
    ),

  ];

}