import 'package:shared_preferences/shared_preferences.dart';

class LocalPracticeThemeStorage {

  static final LocalPracticeThemeStorage _instance = LocalPracticeThemeStorage._internal();
  late SharedPreferences _pref;

  static const PRACTICE_THEME_KEY = "practiceThemeKey";

  factory LocalPracticeThemeStorage() {
    return _instance;
  }

  LocalPracticeThemeStorage._internal();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> setTheme(String? theme) async {
    await _pref.setString(PRACTICE_THEME_KEY, theme ?? '');
  }

  String? getTheme() {
    return _pref.getString(PRACTICE_THEME_KEY);
  }

}