import 'package:shared_preferences/shared_preferences.dart';

class LocalDeviceUuidStorage {

  static final LocalDeviceUuidStorage _instance = LocalDeviceUuidStorage._internal();
  late SharedPreferences _prefs;

  final _deviceUuidKey = "deviceUuid";

  factory LocalDeviceUuidStorage() {
    return _instance;
  }

  LocalDeviceUuidStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setDeviceUuid(String uuid) async {
    await _prefs.setString(_deviceUuidKey, uuid);
  }

  String? getDeviceUuid() {
    return _prefs.getString(_deviceUuidKey);
  }

}