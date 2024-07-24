import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalScriptStorage {

  static final LocalScriptStorage _instance = LocalScriptStorage._internal();
  late SharedPreferences _prefs;

  final _inputScriptContentKey = "inputScriptContent";
  final _inputScriptIdKey = "inputScriptId";
  final _inputScriptTotalExpectedTimeMilliKey = "inputScriptTotalExpectedTime";

  factory LocalScriptStorage() {
    return _instance;
  }

  LocalScriptStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setInputScriptContent(List<String> scriptList) async {
    debugPrint("저장함: ${scriptList.length}줄");
    await _prefs.setStringList(_inputScriptContentKey, scriptList);
  }

  List<String>? getInputScriptContent() {
    debugPrint("불러옴: ${_prefs.getStringList(_inputScriptContentKey)?.length}줄");
    return _prefs.getStringList(_inputScriptContentKey);
  }

  Future<void> setInputScriptId(int scriptId) async {
    debugPrint("저장함: scriptId: ${scriptId}");
    await _prefs.setInt(_inputScriptIdKey, scriptId);
  }

  int? getInputScriptId() {
    debugPrint("불러옴: scriptId: ${_prefs.getInt(_inputScriptIdKey)}");
    return _prefs.getInt(_inputScriptIdKey);
  }

  Future<void> setInputScriptTotalExpectedTimeMilli(int scriptTotalExpectedTime) async {
    debugPrint("저장함: scriptTotalExpectedTime: ${scriptTotalExpectedTime}");
    await _prefs.setInt(_inputScriptTotalExpectedTimeMilliKey, scriptTotalExpectedTime);
  }

  int? getInputScriptTotalExpectedTimeMilli() {
    debugPrint("불러옴: scriptTotalExpectedTime: ${_prefs.getInt(_inputScriptTotalExpectedTimeMilliKey)}");
    return _prefs.getInt(_inputScriptTotalExpectedTimeMilliKey);
  }

}