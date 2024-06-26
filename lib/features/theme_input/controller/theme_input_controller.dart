import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local_practice_theme_storage.dart';
import '../../common/data_source/local_practice_mode_storage.dart';

class ThemeInputCtr extends GetxController {
  String? _theme;

  void updateTheme(String? newTheme) {
    _theme = newTheme;
  }

  Future<void> saveTheme() async {
    await LocalPracticeThemeStorage().setTheme(_theme);
  }

  void finishButton(BuildContext context) async {
    await saveTheme();
    if(context.mounted) {
      if (LocalPracticeModeStorage().getMode() == PracticeMode.withScript) {
        Navigator.pushNamed(context, '/scriptInput');
      }
      else if (LocalPracticeModeStorage().getMode() == PracticeMode.noScript) {
        Navigator.pushNamed(context, '/voiceRecodeNoScript');
      }
    }
  }
}