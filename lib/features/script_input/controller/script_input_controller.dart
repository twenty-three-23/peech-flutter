import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/mock/mock_script_expected_time_data_source.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/remote/remote_script_expected_time_data_source.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_script_input_data_source.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/script_input_paragraphs_model.dart';
import 'package:swm_peech_flutter/features/common/models/script_id_model.dart';



class ScriptInputCtr extends GetxController {

  //대본 입력 데이터
  Rx<List<TextEditingController>> script = Rx<List<TextEditingController>>([ TextEditingController() ]);
  final ScriptInputParagraphsModel _script = ScriptInputParagraphsModel(paragraphs: [ '' ]);

  //발표 전 대본 기반 에상 시간
  ExpectedTimeModel? _scriptExpectedTime;
  Rx<ExpectedTimeModel?> scriptExpectedTime = Rx<ExpectedTimeModel?>(null);

  //스크립트 예상시간 로딩 유무
  Rx<bool> expectedTimeIsLoading = false.obs;
  Rx<bool> scriptInputIsLoading = false.obs;

  List<String>? _expectedTimeScript;
  Rx<List<String>?> expectedTimeScript = Rx<List<String>?>(null);

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
    await LocalScriptStorage().setInputScriptContent(_script.paragraphs ?? List.empty());
  }

  Future<void> saveScriptId(int scriptId) async {
    await LocalScriptStorage().setInputScriptId(scriptId);
  }

  void gotoPracticeBtn(BuildContext context) async {
    try {
      expectedTimeIsLoading.value = true;
      int scriptExpectedTimeMilliSec = toMilliSec(scriptExpectedTime.value?.expectedTimeByScript ?? "00:00:00");
      await LocalScriptStorage().setInputScriptTotalExpectedTimeMilli(scriptExpectedTimeMilliSec);
      Navigator.pushNamed(context, '/voiceRecodeWithScript');
    } catch(e) {
      print("[gotoPracticeBtn] Exception: $e");
      rethrow;
    } finally {
      expectedTimeIsLoading.value = false;
    }

  }

  int toMilliSec(String expectedTime) {
    List<String> time = expectedTime.split(".");
    List<String> timeList = time[0].split(":");
    int hour = int.parse(timeList[0]);
    int min = int.parse(timeList[1]);
    int sec = int.parse(timeList[2]);
    int milli =  0;
    if(time.length >= 2) milli = int.parse(time[1]);
    return (hour * 60 * 60 + min * 60 + sec) * 1000 + milli;
  }

  Future<ScriptIdModel> postScript(int themeId, ScriptInputParagraphsModel script) async {
    try {
      RemoteScriptInputDataSource remoteScriptInputDataSource = RemoteScriptInputDataSource(AuthDioFactory().dio);
      ScriptIdModel? scriptId = await remoteScriptInputDataSource.postScript(themeId, script.toJson());
      if(scriptId == null) throw(Exception("[postScript] scriptId is null!"));
      return scriptId;
    } on DioException catch (e) {
      print("[postScript] request body: [${e.requestOptions.data}] message: [${e.response?.data['message']}] DioException: $e");
      rethrow;
    } catch (e) {
      print("[postScript] Exception: $e");
      rethrow;
    }
  }

  Future<ExpectedTimeModel> getExpectedTime(int themeId, int scriptId) async {
    try {
      final RemoteScriptExpectedTimeDataSource scriptExpectedTimeDataSource = RemoteScriptExpectedTimeDataSource(AuthDioFactory().dio);
      ExpectedTimeModel expectedTimeModel = await scriptExpectedTimeDataSource.getExpectedTime(themeId, scriptId);
      return expectedTimeModel;
    } on DioException catch(e) {
      print("[getExpectedTime] message:[${e.response?.data['message']}] DioException: $e");
      rethrow;
    } catch(e) {
      print("[getExpectedTime] Exception: $e");
      rethrow;
    }
  }

  Future<ExpectedTimeModel> getExpectedTimeTest() async {
    Future.delayed(const Duration(seconds: 2));
    final MockScriptExpectedTimeDataSource scriptExpectedTimeDataSource = MockScriptExpectedTimeDataSource();
    return scriptExpectedTimeDataSource.getExpectedTimeTest();
  }

  int getThemeId() {
    LocalPracticeThemeStorage localPracticeThemeStorage = LocalPracticeThemeStorage();
    String? themeId = localPracticeThemeStorage.getThemeId();
    if(themeId == null || themeId == "") throw(Exception("[getThemeId] theme id is null or empty string!"));
    return int.parse(themeId);
  }

  void inputConfirmBtn(BuildContext context) async {
    scriptInputIsLoading.value = true;
    int themeId = getThemeId();
    removeEmptyParagraphs(); // 빈 문단들 제거
    if(_script.paragraphs?.isEmpty ?? false) {
      scriptInputIsLoading.value = false;
      showCommonDialog(
        context: context,
        title: '에러',
        message: '대본을 입력해주세요',
        showFirstButton: false,
        secondButtonText: '확인',
        secondAction: () { Navigator.of(context).pop(); },
      );
      return;
    }
    ScriptIdModel scriptIdModel = await postScript(themeId, _script);
    int scriptId = scriptIdModel.scriptId ?? 0;
    await saveScriptContent();
    await saveScriptId(scriptId);

    if(context.mounted) {
      Navigator.pushNamed(context, '/scriptInput/result');
      scriptInputIsLoading.value = false;
    }
  }

  void removeEmptyParagraphs() {
    for(int i = 0; i < _script.paragraphs!.length; i++) {
      if(_script.paragraphs![i] == '') {
        _script.paragraphs!.removeAt(i);
        script.value[i].dispose();
        script.value.removeAt(i);
        i--;
      }
    }
  }

  Future<void> scriptExpectedTimeScriptInit() async {
    expectedTimeIsLoading.value = true;
    scriptExpectedTime.value = null;
    expectedTimeScript.value = null;
    _expectedTimeScript = getExpectedTimeScript();
    int themeId = getThemeId();
    int scriptId = LocalScriptStorage().getInputScriptId() ?? 0;
    _scriptExpectedTime = await getExpectedTime(themeId, scriptId);
    expectedTimeScript.value = _expectedTimeScript;
    scriptExpectedTime.value = _scriptExpectedTime;
    expectedTimeIsLoading.value = false;
  }

  List<String>? getExpectedTimeScript() {
    LocalScriptStorage localScriptStorage = LocalScriptStorage();
    return localScriptStorage.getInputScriptContent();
  }

}