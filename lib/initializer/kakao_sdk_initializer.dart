import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoSdkInitializer {

  Future<void> initialize() async {
    await dotenv.load(fileName: "assets/config/keys.env");
    String nativeAppKey = dotenv.env['KAKAO_SDK_NATIVE_APP_KEY']!;
    KakaoSdk.init(
      nativeAppKey: nativeAppKey,
    );
  }

}