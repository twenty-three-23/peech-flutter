import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/dataSource/local_script_stroage.dart';
import 'package:swm_peech_flutter/features/scriptInput/dataSource/script_expected_time_data_source.dart';

import '../../common/models/script_expected_time_model.dart';



class ScriptInputCtr extends GetxController {

  //대본 예상 시간 데이터 소스
  final ScriptExpectedTimeDataSource _scriptExpectedTimeDataSource = ScriptExpectedTimeDataSource();

  //대본 입력 데이터
  Rx<List<String>> script = Rx<List<String>>([ '' ]);
  final List<String> _script = [ '' ];

  //발표 전 대본 기반 에상 시간
  ScriptExpectedTimeModel? _scriptExpectedTime;
  Rx<ScriptExpectedTimeModel?> scriptExpectedTime = Rx<ScriptExpectedTimeModel?>(null);

  //스크립트 예상시간 로딩 유무
  Rx<bool> isLoading = false.obs;

  void updateScript(int index, String newScript) {
    _script[index] = newScript;
    script.value = _script;
  }

  Future<void> saveScript() async {
    await LocalScriptStorage().setScript(_script);
  }

  Future<void> gotoPractice(BuildContext context) async {
    await saveScript();
    if(context.mounted) {
      Navigator.pushNamed(context, '/voiceRecodeWithScript');
    }
  }

  void getExpectedTime() async {
    isLoading.value = true;
    script.value = List.empty(growable: true);
    scriptExpectedTime.value = null;
    _scriptExpectedTime = await _scriptExpectedTimeDataSource.getExpectedTimeTest();
    _scriptExpectedTime?.expectedTimePerParagraphs?.sort((a, b) => (a?.paragraphId ?? 0).compareTo(b?.paragraphId ?? 0));
    _scriptExpectedTime?.paragraphs?.sort((a, b) => (a?.id ?? 0).compareTo(b?.id ?? 0));
    scriptExpectedTime.value = _scriptExpectedTime;
    isLoading.value = false;
  }

}