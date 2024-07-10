import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/mock/mock_script_expected_time_data_source.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/remote/remote_script_input_data_source.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/script_input/model/paragraphs_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/script_id_model.dart';
import '../../common/models/script_expected_time_model.dart';



class ScriptInputCtr extends GetxController {

  //대본 예상 시간 데이터 소스
  final MockScriptExpectedTimeDataSource _scriptExpectedTimeDataSource = MockScriptExpectedTimeDataSource();

  //대본 입력 데이터
  Rx<List<TextEditingController>> script = Rx<List<TextEditingController>>([ TextEditingController() ]);
  final ParagraphsModel _script = ParagraphsModel(paragraphs: []);

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
    _script.paragraphs?[index] = newScript;
  }

  void addParagraph() {
    _script.paragraphs?.add('');
    script.value.add(TextEditingController());
    script.value = script.value.toList();
  }

  void removeParagraph(int index) {
    _script.paragraphs?.removeAt(index);
    script.value[index].dispose();
    script.value.removeAt(index);
    script.value = script.value.toList();
  }

  Future<void> saveScriptContent() async {
    await LocalScriptStorage().setScriptContent(_script.paragraphs ?? List.empty());
  }

  Future<void> saveScriptId(int scriptId) async {
    await LocalScriptStorage().setScriptId(scriptId);
  }

  void gotoPracticeBtn(BuildContext context) {
    Navigator.pushNamed(context, '/voiceRecodeWithScript');
  }

  Future<ScriptIdModel> postScript() async {
    try {
      Dio dio = Dio();
      LocalPracticeThemeStorage localPracticeThemeStorage = LocalPracticeThemeStorage();
      String? themeId = localPracticeThemeStorage.getThemeId();
      if(themeId == null) throw(Exception("[postScript] theme id is null!"));
      RemoteScriptInputDataSource remoteScriptInputDataSource = RemoteScriptInputDataSource(dio);
      ScriptIdModel scriptId = await remoteScriptInputDataSource.postScript(int.parse(themeId), _script.toJson());
      return scriptId;
    } on DioException catch (e) {
      print("[postScript] DioException: $e");
      rethrow;
    } catch (e) {
      print("[postScript] Exception: $e");
      rethrow;
    }
  }

  void inputConfirmBtn(BuildContext context) async {
    ScriptIdModel scriptIdModel = await postScript();
    await saveScriptContent();
    await saveScriptId(scriptIdModel.scriptId ?? 0);
    Navigator.pushNamed(context, '/scriptInput/result');
    isLoading.value = true;
    scriptExpectedTime.value = null;
    _scriptExpectedTime = await _scriptExpectedTimeDataSource.getExpectedTimeTest();
    _scriptExpectedTime?.expectedTimePerParagraphs?.sort((a, b) => (a?.paragraphId ?? 0).compareTo(b?.paragraphId ?? 0));
    _scriptExpectedTime?.paragraphs?.sort((a, b) => (a?.id ?? 0).compareTo(b?.id ?? 0));
    scriptExpectedTime.value = _scriptExpectedTime;
    isLoading.value = false;
  }

}