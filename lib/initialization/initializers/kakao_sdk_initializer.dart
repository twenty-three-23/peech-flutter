import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoSdkInitializer {
  Future<void> initialize() async {
    print("[KakaoSdkInitializer] initialize");
    await dotenv.load(fileName: "assets/config/keys.env");
    final String nativeAppKey = dotenv.env['KAKAO_SDK_NATIVE_APP_KEY'] ?? 'KAKAO_SDK_NATIVE_APP_KEY';
    final String jsAppKey = dotenv.env['KAKAO_SDK_JS_APP_KEY'] ?? 'KAKAO_SDK_JS_APP_KEY';
    KakaoSdk.init(nativeAppKey: nativeAppKey, javaScriptAppKey: jsAppKey);
  }
}
