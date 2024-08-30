import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        home: Center(
          child: Container(
            width: MediaQuery.of(context).size.width > 600 ? 600 : MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
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
