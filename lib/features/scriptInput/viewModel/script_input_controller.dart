import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/scriptInput/dataSource/script_expected_time_data_source.dart';

import '../model/script_expected_time_model.dart';


class ScriptInputController extends GetxController {

  final ScriptExpectedTimeDataSource _scriptExpectedTimeDataSource = ScriptExpectedTimeDataSource();

  Rx<String?> script = Rx<String?>(null);
  Rx<ScriptExpectedTimeModel?> scriptExpectedTime = null.obs;

  void updateScript(String newScript) {
    script.value = newScript;
  }

}