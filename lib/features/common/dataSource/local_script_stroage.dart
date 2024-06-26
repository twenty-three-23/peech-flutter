import 'package:shared_preferences/shared_preferences.dart';

class LocalScriptStorage {

  static final LocalScriptStorage _instance = LocalScriptStorage._internal();
  late SharedPreferences _prefs;

  factory LocalScriptStorage() {
    return _instance;
  }

  LocalScriptStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setScript(List<String> scriptList) async {
    await _prefs.setStringList("currentScript", scriptList);
  }

  List<String>? getScript() {
    return _prefs.getStringList("currentScript");
  }

}