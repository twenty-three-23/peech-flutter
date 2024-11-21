import 'package:flutter/cupertino.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceUuidInitializer {
  late final LocalDeviceUuidStorage uuidStorage;

  DeviceUuidInitializer({required this.uuidStorage});

  Future<void> initialize() async {
    try {
      String? uuid = await uuidStorage.getDeviceUuid();
      if (uuid == null) {
        uuid = const Uuid().v4();
        uuidStorage.setDeviceUuid(uuid);
      }
      debugPrint("[DeviceUuidInitializer] uuid: $uuid");
    } catch (e) {
      throw "can't initialize device uuid: $e";
    }
  }
}
