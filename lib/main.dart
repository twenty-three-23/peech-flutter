import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_social_login_bottom_sheet.dart';
import 'package:swm_peech_flutter/initializer/app_initializer.dart';
import 'package:swm_peech_flutter/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/common/events/social_login_bottom_sheet_open_event.dart';
import 'package:swm_peech_flutter/features/common/platform/is_mobile_on_mobile.dart'
    if (dart.library.html) 'package:swm_peech_flutter/features/common/platform/is_mobile_on_web.dart' as platform_client;

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await AppInitializer().initialize();
    AppEventBus.instance.on<SocialLoginBottomSheetOpenEvent>().listen((event) {
      print("[SocialLoginEvent] state: ${event.socialLoginBottomSheetState}, from: ${event.fromWhere}");
      showSocialLoginBottomSheet(navigatorKey.currentContext!, event.socialLoginBottomSheetState);
    });
    FlutterError.onError = (FlutterErrorDetails details) {
      print("[FlutterError] 에러 발생: ${details.exception}");
    }; //앱 정보 전역 컨트롤러

    runApp(MyApp(navigatorKey: navigatorKey));
  }, (Object error, StackTrace stack) {
    print("[runZonedGuarded] 에러 발생: $error");
  });
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({required this.navigatorKey, super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      //web 인 경우
      return MaterialApp(
        home: Container(
          color: const Color(0xFFf1f1f1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (platform_client.isIphone() == true)
                const AlertDialog(
                  title: Text(
                    '플랫폼 에러',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 26 / 18,
                    ),
                  ),
                  content: Text(
                    '사파리, IOS에서는 호환되지 않습니다.\nPC를 통해 접속해주세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                    ),
                  ),
                ),
              if (platform_client.isMobile() == false)
                const SizedBox(
                  width: 220,
                ),
              Container(
                width: MediaQuery.of(context).size.width > 600 ? 600 : MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.4,
                  ),
                ),
                child: GetMaterialApp(
                  navigatorKey: navigatorKey,
                  getPages: Routers.routers,
                  initialRoute: Routers.INITIAL,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('ko', 'KR'),
                  ],
                ),
              ),
              if (platform_client.isMobile() == false)
                const SizedBox(
                  width: 20,
                ),
              if (platform_client.isMobile() == false)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (platform_client.isUnavailableClient() == true)
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '사파리, IOS에서는 호환되지 않습니다.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      'assets/images/android_QR_code.svg',
                      semanticsLabel: 'app QR code',
                      width: 200,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    } else {
      //android, ios 인 경우
      return GetMaterialApp(
        navigatorKey: navigatorKey,
        getPages: Routers.routers,
        initialRoute: Routers.INITIAL,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
        ],
      );
    }
  }
}
