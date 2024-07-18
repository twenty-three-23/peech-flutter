import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_error_dialog.dart';
import 'package:swm_peech_flutter/initializer/app_initializer.dart';
import 'package:swm_peech_flutter/routers/routers.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppInitializer().initialize();
    FlutterError.onError = (FlutterErrorDetails details) {
      showErrorDialog(navigatorKey, "${details.exception}}");
      print("에러 발생: ${details.exception}");
    };
    runApp(MyApp(navigatorKey: navigatorKey));
  },
    (Object error, StackTrace stack) {
      showErrorDialog(navigatorKey, "$error");
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
