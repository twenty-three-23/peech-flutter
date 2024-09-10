import 'package:swm_peech_flutter/initializer/firebase_initializer.dart';
import 'package:swm_peech_flutter/initializer/global_controllers_initializer.dart';
import 'package:swm_peech_flutter/initializer/kakao_sdk_initializer.dart';
import 'package:swm_peech_flutter/initializer/local_storage_initializer.dart';

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
