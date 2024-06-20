import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/scriptInput/dataSource/script_expected_time_data_source.dart';

import '../model/script_expected_time_model.dart';


class ScriptInputController extends GetxController {

  ScriptExpectedTimeDataSource _scriptExpectedTimeDataSource = ScriptExpectedTimeDataSource();

  String? _script;
  Rx<String?> script = Rx<String?>(null);
  ScriptExpectedTimeModel? _scriptExpectedTime;
  Rx<ScriptExpectedTimeModel?> scriptExpectedTime = Rx<ScriptExpectedTimeModel?>(null);
  Rx<bool> isLoading = false.obs;

  void updateScript(String newScript) {
    _script = newScript;
    script.value = _script;
  }

  void getExpectedTime() async {
    isLoading.value = true;
    scriptExpectedTime.value = null;
    _scriptExpectedTime = await _scriptExpectedTimeDataSource.getExpectedTimeTest();
    _scriptExpectedTime?.expectedTimePerParagraphs?.sort((a, b) => (a?.paragraphId ?? 0).compareTo(b?.paragraphId ?? 0));
    _scriptExpectedTime?.paragraphs?.sort((a, b) => (a?.id ?? 0).compareTo(b?.id ?? 0));
    scriptExpectedTime.value = _scriptExpectedTime;
    isLoading.value = false;
  }

}