import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthTokenStorage {

  static final LocalAuthTokenStorage _instance = LocalAuthTokenStorage._internal();
  late SharedPreferences _prefs;

  final _accessTokenKey = "accessTokenKey";
  final _refreshTokenKey = "refreshTokenKey";

  factory LocalAuthTokenStorage() {
    return _instance;
  }

  LocalAuthTokenStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
  }

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

}