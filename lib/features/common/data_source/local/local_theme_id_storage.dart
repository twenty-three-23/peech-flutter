import 'package:shared_preferences/shared_preferences.dart';

class LocalThemeIdStorage {

  static final LocalThemeIdStorage _instance = LocalThemeIdStorage._internal();
  late SharedPreferences _prefs;

  static const CURRENT_THEME_KEY = "currentThemeId";

  factory LocalThemeIdStorage() {
    return _instance;
  }

  LocalThemeIdStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setThemeId(String themeId) async {
    await _prefs.setString(CURRENT_THEME_KEY, themeId);
  }

  String? getThemeId() {
    return _prefs.getString(CURRENT_THEME_KEY);
  }

}