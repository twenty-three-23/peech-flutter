import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_social_login_bottom_sheet.dart';
import 'package:swm_peech_flutter/initializer/app_initializer.dart';
import 'package:swm_peech_flutter/routers/routers.dart';

import 'features/common/events/social_login_event.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppInitializer().initialize();
    AppEventBus.instance.on<SocialLoginEvent>().listen((_) {
      print("SocialLoginEvent");
      showSocialLoginBottomSheet(navigatorKey.currentContext!);
    });
    FlutterError.onError = (FlutterErrorDetails details) {
      print("에러 발생: ${details.exception}");
    };
    runApp(MyApp(navigatorKey: navigatorKey));
  },
    (Object error, StackTrace stack) {
      print("에러 발생: $error");
    }
  );
}


class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({required this.navigatorKey, super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      getPages: Routers.routers,
      initialRoute: Routers.INITIAL,
    );
  }
}
