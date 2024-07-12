import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalScriptStorage {

  static final LocalScriptStorage _instance = LocalScriptStorage._internal();
  late SharedPreferences _prefs;

  static const CURRENT_SCRIPT_CONTENT_KEY = "currentScriptContent";
  static const CURRENT_SCRIPT_ID_KEY = "currentScriptId";
  static const CURRENT_SCRIPT_TOTAL_EXPECTED_TIME_KEY = "currentScriptTotalExpectedTime";

  factory LocalScriptStorage() {
    return _instance;
  }

  LocalScriptStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setScriptContent(List<String> scriptList) async {
    debugPrint("저장함: ${scriptList.length}줄");
    await _prefs.setStringList(CURRENT_SCRIPT_CONTENT_KEY, scriptList);
  }

  List<String>? getScriptContent() {
    debugPrint("불러옴: ${_prefs.getStringList(CURRENT_SCRIPT_CONTENT_KEY)?.length}줄");
    return _prefs.getStringList(CURRENT_SCRIPT_CONTENT_KEY);
  }

  Future<void> setScriptId(int scriptId) async {
    debugPrint("저장함: scriptId: ${scriptId}");
    await _prefs.setInt(CURRENT_SCRIPT_ID_KEY, scriptId);
  }

  int? getScriptId() {
    debugPrint("불러옴: scriptId: ${_prefs.getInt(CURRENT_SCRIPT_ID_KEY)}");
    return _prefs.getInt(CURRENT_SCRIPT_ID_KEY);
  }

  Future<void> setScriptTotalExpectedTime(int scriptTotalExpectedTime) async {
    debugPrint("저장함: scriptTotalExpectedTime: ${scriptTotalExpectedTime}");
    await _prefs.setInt(CURRENT_SCRIPT_TOTAL_EXPECTED_TIME_KEY, scriptTotalExpectedTime);
  }

  int? getScriptTotalExpectedTime() {
    debugPrint("불러옴: scriptTotalExpectedTime: ${_prefs.getInt(CURRENT_SCRIPT_TOTAL_EXPECTED_TIME_KEY)}");
    return _prefs.getInt(CURRENT_SCRIPT_TOTAL_EXPECTED_TIME_KEY);
  }

}