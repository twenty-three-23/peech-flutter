import 'package:shared_preferences/shared_preferences.dart';

class LocalScriptStorage {

  static final LocalScriptStorage _instance = LocalScriptStorage._internal();
  late SharedPreferences _prefs;

  static const CURRENT_SCRIPT_KEY = "currentScript";

  factory LocalScriptStorage() {
    return _instance;
  }

  LocalScriptStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setScript(String? script) async {
    await _prefs.setString(CURRENT_SCRIPT_KEY, script ?? "");
  }

  String? getScript() {
    return _prefs.getString(CURRENT_SCRIPT_KEY);
  }

}