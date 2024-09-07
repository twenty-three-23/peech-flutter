import 'package:shared_preferences/shared_preferences.dart';

class LocalReviewStorage {
  static final LocalReviewStorage _instance = LocalReviewStorage._internal();
  late SharedPreferences _prefs;

  final _isReviewSubmittedKey = "isReviewSubmitted";

  factory LocalReviewStorage() {
    return _instance;
  }

  LocalReviewStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setIsReviewSubmitted(bool value) async {
    await _prefs.setBool(_isReviewSubmittedKey, value);
  }

  bool? getIsReviewSubmitted() {
    return _prefs.getBool(_isReviewSubmittedKey);
  }
}
