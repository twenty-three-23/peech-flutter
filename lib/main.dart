import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swm_peech_flutter/features/common/controllers/app_info_controller.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_social_login_bottom_sheet.dart';
import 'package:swm_peech_flutter/initializer/app_initializer.dart';
import 'package:swm_peech_flutter/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/common/events/social_login_bottom_sheet_open_event.dart';
import 'package:swm_peech_flutter/features/common/platform/is_mobile_on_mobile.dart'
    if (dart.library.html) 'package:swm_peech_flutter/features/common/platform/is_mobile_on_web.dart' as platform;

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    Get.put(UserInfoController()); //유저 정보 전역 컨트롤러
    Get.put(AppInfoController()); // 앱 정보 전역 컨트롤러

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
              if (platform.isMobile() == false)
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
              if (platform.isMobile() == false)
                const SizedBox(
                  width: 20,
                ),
              if (platform.isMobile() == false)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
