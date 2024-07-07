import 'package:shared_preferences/shared_preferences.dart';

class LocalPracticeThemeStorage {

  static final LocalPracticeThemeStorage _instance = LocalPracticeThemeStorage._internal();
  late SharedPreferences _pref;

  static const PRACTICE_THEME_KEY = "practiceThemeKey";
  static const CURRENT_THEME_KEY = "currentThemeId";

  factory LocalPracticeThemeStorage() {
    return _instance;
  }

  LocalPracticeThemeStorage._internal();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> setThemeText(String? theme) async {
    await _pref.setString(PRACTICE_THEME_KEY, theme ?? '');
  }

  String? getThemeText() {
    return _pref.getString(PRACTICE_THEME_KEY);
  }

  Future<void> setThemeId(String themeId) async {
    await _pref.setString(CURRENT_THEME_KEY, themeId);
  }

  String? getThemeId() {
    return _pref.getString(CURRENT_THEME_KEY);
  }


}