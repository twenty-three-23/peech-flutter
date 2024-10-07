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
    print("=== [AppInitializer] initialize end ===");
  }
}
