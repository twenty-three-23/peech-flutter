import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalScriptStorage {

  static final LocalScriptStorage _instance = LocalScriptStorage._internal();
  late SharedPreferences _prefs;

  static const INPUT_SCRIPT_CONTENT_KEY = "inputScriptContent";
  static const INPUT_SCRIPT_ID_KEY = "inputScriptId";
  static const INPUT_SCRIPT_TOTAL_EXPECTED_TIME_MILLI_KEY = "inputScriptTotalExpectedTime";

  factory LocalScriptStorage() {
    return _instance;
  }

  LocalScriptStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setInputScriptContent(List<String> scriptList) async {
    debugPrint("저장함: ${scriptList.length}줄");
    await _prefs.setStringList(INPUT_SCRIPT_CONTENT_KEY, scriptList);
  }

  List<String>? getInputScriptContent() {
    debugPrint("불러옴: ${_prefs.getStringList(INPUT_SCRIPT_CONTENT_KEY)?.length}줄");
    return _prefs.getStringList(INPUT_SCRIPT_CONTENT_KEY);
  }

  Future<void> setInputScriptId(int scriptId) async {
    debugPrint("저장함: scriptId: ${scriptId}");
    await _prefs.setInt(INPUT_SCRIPT_ID_KEY, scriptId);
  }

  int? getInputScriptId() {
    debugPrint("불러옴: scriptId: ${_prefs.getInt(INPUT_SCRIPT_ID_KEY)}");
    return _prefs.getInt(INPUT_SCRIPT_ID_KEY);
  }

  Future<void> setInputScriptTotalExpectedTimeMilli(int scriptTotalExpectedTime) async {
    debugPrint("저장함: scriptTotalExpectedTime: ${scriptTotalExpectedTime}");
    await _prefs.setInt(INPUT_SCRIPT_TOTAL_EXPECTED_TIME_MILLI_KEY, scriptTotalExpectedTime);
  }

  int? getInputScriptTotalExpectedTimeMilli() {
    debugPrint("불러옴: scriptTotalExpectedTime: ${_prefs.getInt(INPUT_SCRIPT_TOTAL_EXPECTED_TIME_MILLI_KEY)}");
    return _prefs.getInt(INPUT_SCRIPT_TOTAL_EXPECTED_TIME_MILLI_KEY);
  }

}