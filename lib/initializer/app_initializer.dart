import 'package:swm_peech_flutter/initializer/kakao_sdk_initializer.dart';
import 'package:swm_peech_flutter/initializer/local_storage_initializer.dart';

class AppInitializer {
  Future<void> initialize() async {
    await Future.wait([
      LocalStorageInitializer().initialize(),
      KakaoSdkInitializer().initialize(),
    ]);
  }
}
