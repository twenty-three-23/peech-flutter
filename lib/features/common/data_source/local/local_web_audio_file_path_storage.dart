import 'package:shared_preferences/shared_preferences.dart';

class LocalWebAudioFilePathStorage {

  static final LocalWebAudioFilePathStorage _instance = LocalWebAudioFilePathStorage._internal();
  late SharedPreferences _prefs;

  final _webAudioFilePath = "webAudioFilePath";

  factory LocalWebAudioFilePathStorage() {
    return _instance;
  }

  LocalWebAudioFilePathStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setWebAudioFilePath(String path) async {
    await _prefs.setString(_webAudioFilePath, path);
  }

  String? getWebAudioFilePath() {
    return _prefs.getString(_webAudioFilePath);
  }

}