import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_info_storage.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_device_info/platform_device_info.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_social_login_bottom_sheet.dart';
import 'package:swm_peech_flutter/initialization/app_initializer.dart';
import 'package:swm_peech_flutter/navigator_observers/home_navigator_observer.dart';
import 'package:swm_peech_flutter/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/common/events/social_login_bottom_sheet_open_event.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

late final _firstScreen;

void main() async {
  // 앱 전역 에러 처리
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); // 앱 초기화(비동기 처리 전에 실행되어야 함)

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // splash screen 유지

    await AppInitializer().initialize(); // 앱 초기화(비동기 처리)

    // 첫 화면 결정
    if (LocalUserInfoStorage().getIsOnboardingFinished()) {
      print('온보딩을 이미 완료함.');
      _firstScreen = Routers.INITIAL;
    } else {
      print('온보딩을 완료하지 않았습니다. 첫 화면을 온보딩 화면으로 설정합니다.');
      _firstScreen = '/onboarding';
    }

    if (PlatformDeviceInfo.isIOS() && !kIsWeb) {
      final status = await AppTrackingTransparency.requestTrackingAuthorization();
      print('AppTrackingTransparency status: $status');
    }

    FlutterNativeSplash.remove(); // splash screen 제거

    // Flutter 에러 처리
    FlutterError.onError = (FlutterErrorDetails details) {
      print("[FlutterError] 에러 발생: ${details.exception}");
    };

    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    print("[runZonedGuarded] 에러 발생: $error");
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // 소셜 로그인 바텀 시트 이벤트 버스
    AppEventBus.instance.on<SocialLoginBottomSheetOpenEvent>().listen((event) {
      print("[SocialLoginEvent] state: ${event.socialLoginBottomSheetState}, from: ${event.fromWhere}");
      showSocialLoginBottomSheet(widget.navigatorKey.currentContext!, event.socialLoginBottomSheetState);
    });
    super.initState();
  }

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
              if (PlatformDeviceInfo.isMobile() == false)
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
                  navigatorKey: widget.navigatorKey,
                  getPages: Routers.routers,
                  initialRoute: _firstScreen,
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
              if (PlatformDeviceInfo.isMobile() == false)
                const SizedBox(
                  width: 20,
                ),
              if (PlatformDeviceInfo.isMobile() == false)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (PlatformDeviceInfo.isRecordUnavailableClient() == true)
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '사파리, IOS에서는 웹 브라우저에서 녹음 기능이 호환되지 않습니다. 다른 플랫폼에서 이용해주세요.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
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
        navigatorKey: widget.navigatorKey,
        navigatorObservers: [
          HomeNavigatorObserver(),
        ],
        getPages: Routers.routers,
        initialRoute: _firstScreen,
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
