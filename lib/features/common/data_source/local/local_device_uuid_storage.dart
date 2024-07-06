import 'package:shared_preferences/shared_preferences.dart';

class LocalDeviceUuidStorage {

  static final LocalDeviceUuidStorage _instance = LocalDeviceUuidStorage._internal();
  late SharedPreferences _prefs;

  static const DEVICE_UUID_KEY = "deviceUuid";

  factory LocalDeviceUuidStorage() {
    return _instance;
  }

  LocalDeviceUuidStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> setDeviceUuid(String uuid) async {
    await _prefs.setString(DEVICE_UUID_KEY, uuid);
  }

  String? getDeviceUuid() {
    return _prefs.getString(DEVICE_UUID_KEY);
  }

}