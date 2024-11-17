import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/firebase_messaging/firebase_messaging_manager.dart';
import 'package:swm_peech_flutter/initialization/initializers/device_uuid_initializer.dart';
import 'package:swm_peech_flutter/initialization/initializers/firebase_initializer.dart';
import 'package:swm_peech_flutter/initialization/initializers/global_controllers_initializer.dart';
import 'package:swm_peech_flutter/initialization/initializers/kakao_sdk_initializer.dart';
import 'package:swm_peech_flutter/initialization/initializers/local_storage_initializer.dart';

class AppInitializer {
  Future<void> initialize() async {
    print("=== [AppInitializer] initialize start ===");
    await Future.wait([
      LocalStorageInitializer().initialize(),
      KakaoSdkInitializer().initialize(),
      GlobalControllersInitializer().initialize(),
      FirebaseInitializer().initialize(),
    ]);
    await DeviceUuidInitializer(uuidStorage: LocalDeviceUuidStorage()).initialize();
    await FirebaseMessagingManager.initialize();
    print("=== [AppInitializer] initialize end ===");
  }
}
