import 'package:shared_preferences/shared_preferences.dart';

class LocalUserTokenStorage {

  static final LocalUserTokenStorage _instance = LocalUserTokenStorage._internal();
  late SharedPreferences _prefs;

  final _userTokenKey = "userToken";

  factory LocalUserTokenStorage() {
    return _instance;
  }

  LocalUserTokenStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setUserToken(String userToken) async {
    await _prefs.setString(_userTokenKey, userToken);
  }

  String? getUserToken() {
    return _prefs.getString(_userTokenKey);
  }

}