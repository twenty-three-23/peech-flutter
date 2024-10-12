import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserInfoStorage {
  static final LocalUserInfoStorage _instance = LocalUserInfoStorage._internal();
  late SharedPreferences _prefs;

  final _isOnboardingFinishedKey = "isOnboardingFinished";

  factory LocalUserInfoStorage() {
    return _instance;
  }

  LocalUserInfoStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setIsOnboardingFinished(bool isFinished) async {
    debugPrint("저장함: [isOnboardingFinished] ${isFinished}");
    await _prefs.setBool(_isOnboardingFinishedKey, isFinished);
  }

  bool getIsOnboardingFinished() {
    debugPrint("불러옴: [isOnboardingFinished] ${_prefs.getBool(_isOnboardingFinishedKey)}");
    return _prefs.getBool(_isOnboardingFinishedKey) ?? false;
  }
}
