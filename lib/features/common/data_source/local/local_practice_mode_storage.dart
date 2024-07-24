import 'package:shared_preferences/shared_preferences.dart';

enum PracticeMode {
  noScript,
  withScript,
}

class LocalPracticeModeStorage {

  static final _instance = LocalPracticeModeStorage._internal();
  late SharedPreferences _pref;

  final _practiceModeKey = "practiceMode";

  factory LocalPracticeModeStorage() {
    return _instance;
  }

  LocalPracticeModeStorage._internal();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> setMode(PracticeMode? mode) async {
    await _pref.setString(_practiceModeKey, mode?.name ?? '');
  }

  PracticeMode? getMode() {
    final modeString = _pref.getString(_practiceModeKey);
    if (modeString != null && modeString.isNotEmpty) {
      try {
        return PracticeMode.values.firstWhere((e) => e.name == modeString);
      }
      catch (e) { // enum에 해당하는 값을 찾지 못함
        return null;
      }
    }
    return null;
  }

}

