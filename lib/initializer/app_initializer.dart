import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/initializer/device_uuid_initializer.dart';
import 'package:swm_peech_flutter/initializer/kakao_sdk_initializer.dart';
import 'package:swm_peech_flutter/initializer/local_storage_initializer.dart';

class AppInitializer {

  Future<void> initialize() async {

    await Future.wait([
      LocalStorageInitializer().initialize(),
      KakaoSdkInitializer().initialize(),

    ]);

    //LocalStorageInitializer().initialize(); 실행 후에 실행되어야 함.
    await DeviceUuidInitializer(uuidStorage: LocalDeviceUuidStorage()).initialize();
  }

}