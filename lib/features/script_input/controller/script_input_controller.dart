import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/script_expected_time_data_source.dart';

import '../../common/models/script_expected_time_model.dart';



class ScriptInputCtr extends GetxController {

  //대본 예상 시간 데이터 소스
  final ScriptExpectedTimeDataSource _scriptExpectedTimeDataSource = ScriptExpectedTimeDataSource();

  //대본 입력 데이터
  Rx<List<TextEditingController>> script = Rx<List<TextEditingController>>([ TextEditingController() ]);
  final List<String> _script = [ '' ];

  //발표 전 대본 기반 에상 시간
  ScriptExpectedTimeModel? _scriptExpectedTime;
  Rx<ScriptExpectedTimeModel?> scriptExpectedTime = Rx<ScriptExpectedTimeModel?>(null);

  //스크립트 예상시간 로딩 유무
  Rx<bool> isLoading = false.obs;

  @override
  void onClose() {
    for (var element in script.value) { element.dispose(); }
    super.onClose();
  }

  void updateScript(int index, String newScript) {
    _script[index] = newScript;
    script.value[index].text = _script[index];
    script.value = script.value.toList();
  }

  void addParagraph() {
    _script.add('');
    script.value.add(TextEditingController());
    script.value = script.value.toList();
  }

  void removeParagraph(int index) {
    _script.removeAt(index);
    script.value[index].dispose();
    script.value.removeAt(index);
    script.value = script.value.toList();
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
    scriptExpectedTime.value = null;
    _scriptExpectedTime = await _scriptExpectedTimeDataSource.getExpectedTimeTest();
    _scriptExpectedTime?.expectedTimePerParagraphs?.sort((a, b) => (a?.paragraphId ?? 0).compareTo(b?.paragraphId ?? 0));
    _scriptExpectedTime?.paragraphs?.sort((a, b) => (a?.id ?? 0).compareTo(b?.id ?? 0));
    scriptExpectedTime.value = _scriptExpectedTime;
    isLoading.value = false;
  }

}