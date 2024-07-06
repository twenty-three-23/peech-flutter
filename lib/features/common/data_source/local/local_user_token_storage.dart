import 'package:shared_preferences/shared_preferences.dart';

class LocalUserTokenStorage {

  static final LocalUserTokenStorage _instance = LocalUserTokenStorage._internal();
  late SharedPreferences _prefs;

  static const USER_TOKEN_KEY = "userToken";

  factory LocalUserTokenStorage() {
    return _instance;
  }

  LocalUserTokenStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setUserToken(String userToken) async {
    await _prefs.setString(USER_TOKEN_KEY, userToken);
  }

  String? getUserToken() {
    return _prefs.getString(USER_TOKEN_KEY);
  }

}