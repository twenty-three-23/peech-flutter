import 'package:swm_peech_flutter/initialize/initializers/firebase_initializer.dart';
import 'package:swm_peech_flutter/initialize/initializers/global_controllers_initializer.dart';
import 'package:swm_peech_flutter/initialize/initializers/kakao_sdk_initializer.dart';
import 'package:swm_peech_flutter/initialize/initializers/local_storage_initializer.dart';

class AppInitializer {
  Future<void> initialize() async {
    await Future.wait([
      LocalStorageInitializer().initialize(),
      KakaoSdkInitializer().initialize(),
      GlobalControllersInitializer().initialize(),
      FirebaseInitializer().initialize(),
    ]);
  }
}
