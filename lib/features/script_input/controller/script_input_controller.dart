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
import 'package:swm_peech_flutter/features/script_input/model/expected_time_by_paragraph_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/script_input_paragraphs_model.dart';
import 'package:swm_peech_flutter/features/common/models/script_id_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/full_script_expected_time_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/full_script_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/script_type.dart';

class ScriptInputCtr extends GetxController {
  //대본 입력 데이터
  Rx<List<TextEditingController>> script = Rx<List<TextEditingController>>([TextEditingController()]);
  final ScriptInputParagraphsModel _script = ScriptInputParagraphsModel(paragraphs: ['']);

  //발표 전 대본 기반 에상 시간
  ExpectedTimeModel? _scriptExpectedTime;
  Rx<ExpectedTimeModel?> scriptExpectedTime = Rx<ExpectedTimeModel?>(null);

  //스크립트 예상시간 로딩 유무
  Rx<bool> expectedTimeIsLoading = false.obs;
  Rx<bool> scriptInputIsLoading = false.obs;

  List<String>? _expectedTimeScript;
  Rx<List<String>?> expectedTimeScript = Rx<List<String>?>(null);

  String fullScript = '';

  @override
  void onClose() {
    for (var element in script.value) {
      element.dispose();
    }
    super.onClose();
  }

  void changeFullScript(String newFullScript) {
    fullScript = newFullScript;
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

  Future<void> saveFullScriptContent(List<String> script) async {
    await LocalScriptStorage().setInputScriptContent(script);
  }

  Future<void> saveScriptId(int scriptId) async {
    await LocalScriptStorage().setInputScriptId(scriptId);
  }

  void gotoPracticeBtn(BuildContext context) async {
    try {
      expectedTimeIsLoading.value = true;
      int scriptExpectedTimeMilliSec = toMilliSec(scriptExpectedTime.value?.expectedTimeByScript ?? "00:00:00");
      await LocalScriptStorage().setInputScriptTotalExpectedTimeMilli(scriptExpectedTimeMilliSec);
      Navigator.pushNamed(context, '/voiceRecordeWithScript');
    } catch (e) {
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
    int milli = 0;
    if (time.length >= 2) milli = int.parse(time[1]);
    return (hour * 60 * 60 + min * 60 + sec) * 1000 + milli;
  }

  Future<ScriptIdModel> postScript(int themeId, ScriptInputParagraphsModel script) async {
    try {
      RemoteScriptInputDataSource remoteScriptInputDataSource = RemoteScriptInputDataSource(AuthDioFactory().dio);
      ScriptIdModel? scriptId = await remoteScriptInputDataSource.postScript(themeId, script.toJson());
      if (scriptId == null) throw (Exception("[postScript] scriptId is null!"));
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
    } on DioException catch (e) {
      print("[getExpectedTime] message:[${e.response?.data['message']}] DioException: $e");
      rethrow;
    } catch (e) {
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
    if (themeId == null || themeId == "") throw (Exception("[getThemeId] theme id is null or empty string!"));
    return int.parse(themeId);
  }

  void fullScriptInputConfirmBtn(BuildContext context) async {
    scriptInputIsLoading.value = true;
    if (fullScript.isEmpty) {
      scriptInputIsLoading.value = false;
      showCommonDialog(
        context: context,
        title: '에러',
        message: '대본을 입력해주세요',
        showFirstButton: false,
        secondButtonText: '확인',
        isSecondButtonToClose: true,
      );
      return;
    }
    if (context.mounted) {
      Navigator.pushNamed(
        context,
        '/scriptInput/result',
        arguments: ScriptType.fullScript,
      );
      scriptInputIsLoading.value = false;
    }
  }

  void inputConfirmBtn(BuildContext context) async {
    scriptInputIsLoading.value = true;
    int themeId = getThemeId();
    removeEmptyParagraphs(); // 빈 문단들 제거
    if (_script.paragraphs?.isEmpty ?? false) {
      scriptInputIsLoading.value = false;
      showCommonDialog(
        context: context,
        title: '에러',
        message: '대본을 입력해주세요',
        showFirstButton: false,
        secondButtonText: '확인',
        isSecondButtonToClose: true,
      );
      return;
    }
    ScriptIdModel scriptIdModel = await postScript(themeId, _script);
    int scriptId = scriptIdModel.scriptId ?? 0;
    await saveScriptContent();
    await saveScriptId(scriptId);

    if (context.mounted) {
      Navigator.pushNamed(
        context,
        '/scriptInput/result',
        arguments: ScriptType.splitedScript,
      );
      scriptInputIsLoading.value = false;
    }
  }

  void removeEmptyParagraphs() {
    for (int i = 0; i < _script.paragraphs!.length; i++) {
      if (_script.paragraphs![i] == '') {
        _script.paragraphs!.removeAt(i);
        script.value[i].dispose();
        script.value.removeAt(i);
        i--;
      }
    }
  }

  Future<void> scriptExpectedTimeScriptInit() async {
    print("[scriptExpectedTimeScriptInit]");
    expectedTimeIsLoading.value = true;
    scriptExpectedTime.value = null;
    expectedTimeScript.value = null;
    _expectedTimeScript = getScript();
    int themeId = getThemeId();
    int scriptId = LocalScriptStorage().getInputScriptId() ?? 0;
    _scriptExpectedTime = await getExpectedTime(themeId, scriptId);
    expectedTimeScript.value = _expectedTimeScript;
    scriptExpectedTime.value = _scriptExpectedTime;
    expectedTimeIsLoading.value = false;
  }

  Future<void> fullScriptExpectedTimeScriptInit() async {
    print("[fullScriptExpectedTimeScriptInit]");
    expectedTimeIsLoading.value = true;
    scriptExpectedTime.value = null;
    expectedTimeScript.value = null;

    RemoteScriptExpectedTimeDataSource remoteScriptExpectedTimeDataSource = RemoteScriptExpectedTimeDataSource(AuthDioFactory().dio);
    FullScriptExpectedTimeModel fullScriptExpectedTimeModel =
        await remoteScriptExpectedTimeDataSource.getExpectedTimeWithFullScript(FullScriptModel(fullScript: fullScript));

    List<String> splitedScript = List.empty(growable: true);
    fullScriptExpectedTimeModel.script?.forEach((element) {
      splitedScript.add(element.paragraph ?? '');
    });

    await saveFullScriptContent(splitedScript);

    _expectedTimeScript = splitedScript;

    List<ExpectedTimeByParagraphModel> expectedTimeByParagraphs = List.empty(growable: true);
    int i = 0;
    fullScriptExpectedTimeModel.script?.forEach((element) {
      expectedTimeByParagraphs.add(ExpectedTimeByParagraphModel(paragraphId: i ?? 0, expectedTimePerParagraph: element.time ?? '00:00:00'));
      i++;
    });

    _scriptExpectedTime = ExpectedTimeModel(
        expectedTimeByScript: fullScriptExpectedTimeModel.totalExpectedTime ?? '00:00:00', expectedTimeByParagraphs: expectedTimeByParagraphs);

    expectedTimeScript.value = _expectedTimeScript;
    scriptExpectedTime.value = _scriptExpectedTime;
    expectedTimeIsLoading.value = false;
  }

  List<String>? getScript() {
    LocalScriptStorage localScriptStorage = LocalScriptStorage();
    return localScriptStorage.getInputScriptContent();
  }
}
