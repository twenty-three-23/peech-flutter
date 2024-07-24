import 'package:shared_preferences/shared_preferences.dart';

class LocalPracticeThemeStorage {

  static final LocalPracticeThemeStorage _instance = LocalPracticeThemeStorage._internal();
  late SharedPreferences _pref;

  final _practiceThemeKey = "practiceThemeKey";
  final _currentThemeKey = "currentThemeId";

  factory LocalPracticeThemeStorage() {
    return _instance;
  }

  LocalPracticeThemeStorage._internal();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> setThemeText(String? theme) async {
    await _pref.setString(_practiceThemeKey, theme ?? '');
  }

  String? getThemeText() {
    return _pref.getString(_practiceThemeKey);
  }

  Future<void> setThemeId(String themeId) async {
    await _pref.setString(_currentThemeKey, themeId);
  }

  String? getThemeId() {
    return _pref.getString(_currentThemeKey);
  }


}