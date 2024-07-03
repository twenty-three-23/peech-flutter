import 'package:flutter/cupertino.dart';
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


  Future<void> setScript(List<String> scriptList) async {
    debugPrint("저장함: ${scriptList.length}줄");
    await _prefs.setStringList(CURRENT_SCRIPT_KEY, scriptList);
  }

  List<String>? getScript() {
    debugPrint("불러옴: ${_prefs.getStringList(CURRENT_SCRIPT_KEY)?.length}줄");
    return _prefs.getStringList(CURRENT_SCRIPT_KEY);
  }

}