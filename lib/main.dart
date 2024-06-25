import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swm_peech_flutter/features/common/dataSource/local_practice_mode_stroage.dart';
import 'package:swm_peech_flutter/features/common/dataSource/local_script_stroage.dart';
import 'package:swm_peech_flutter/routers/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalScriptStorage().init();
    LocalPracticeModeStorage().init();
    return GetMaterialApp(
      getPages: Routers.routers,
      initialRoute: Routers.INITIAL,
    );
  }
}
