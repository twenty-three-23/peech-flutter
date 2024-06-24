import 'package:shared_preferences/shared_preferences.dart';

class LocalScriptStroage {

  static final LocalScriptStroage _instance = LocalScriptStroage._internal();
  late SharedPreferences _prefs;

  factory LocalScriptStroage() {
    return _instance;
  }

  LocalScriptStroage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  void setScript(String? script) async {
    await _prefs.setString("currentScript", script ?? "");
  }

  String? getScript() {
    return _prefs.getString("currentScript");
  }

}