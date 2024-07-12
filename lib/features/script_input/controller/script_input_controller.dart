import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/debug_interceptor.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/mock/mock_script_expected_time_data_source.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/remote/remote_script_expected_time_data_source.dart';
import 'package:swm_peech_flutter/features/script_input/data_source/remote/remote_script_input_data_source.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/paragraphs_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/script_id_model.dart';



class ScriptInputCtr extends GetxController {

  //대본 입력 데이터
  Rx<List<TextEditingController>> script = Rx<List<TextEditingController>>([ TextEditingController() ]);
  final ParagraphsModel _script = ParagraphsModel(paragraphs: [ '' ]);

  //발표 전 대본 기반 에상 시간
  ExpectedTimeModel? _scriptExpectedTime;
  Rx<ExpectedTimeModel?> scriptExpectedTime = Rx<ExpectedTimeModel?>(null);

  //스크립트 예상시간 로딩 유무
  Rx<bool> isLoading = false.obs;

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
    await LocalScriptStorage().setScriptContent(_script.paragraphs ?? List.empty());
  }

  Future<void> saveScriptId(int scriptId) async {
    await LocalScriptStorage().setScriptId(scriptId);
  }

  void gotoPracticeBtn(BuildContext context) async {
    int scriptExectedTimeMilliSec = toMilliSec(scriptExpectedTime.value?.expectedTimeByScript ?? "00:00:00");
    await LocalScriptStorage().setScriptTotalExpectedTimeMilli(scriptExectedTimeMilliSec);
    Navigator.pushNamed(context, '/voiceRecodeWithScript');
  }

  int toMilliSec(String expectedTime) {
    List<String> timeList = expectedTime.split(":");
    int hour = int.parse(timeList[0]);
    int min = int.parse(timeList[1]);
    int sec = int.parse(timeList[2]);
    return (hour * 60 * 60 + min * 60 + sec) * 1000;
  }

  Future<ScriptIdModel> postScript(int themeId) async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(DebugIntercepter());
      dio.interceptors.add(AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()));
      RemoteScriptInputDataSource remoteScriptInputDataSource = RemoteScriptInputDataSource(dio);
      ScriptIdModel scriptId = await remoteScriptInputDataSource.postScript(themeId, _script.toJson());
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
      Dio dio = Dio();
      dio.interceptors.add(DebugIntercepter());
      final RemoteScriptExpectedTimeDataSource scriptExpectedTimeDataSource = RemoteScriptExpectedTimeDataSource(dio);
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
    int themeId = getThemeId();
    ScriptIdModel scriptIdModel = await postScript(themeId);
    int scriptId = scriptIdModel.scriptId ?? 0;
    await saveScriptContent();
    await saveScriptId(scriptId);

    if(context.mounted) {
      Navigator.pushNamed(context, '/scriptInput/result');
    }

    await scriptExpectedTimeScriptInit(themeId, scriptId);
  }

  Future<void> scriptExpectedTimeScriptInit(int themeId, int scriptId) async {
    isLoading.value = true;
    scriptExpectedTime.value = null;
    expectedTimeScript.value = null;
    _expectedTimeScript = getExpectedTimeScript();
    _scriptExpectedTime = await getExpectedTime(themeId, scriptId);
    expectedTimeScript.value = _expectedTimeScript;
    scriptExpectedTime.value = _scriptExpectedTime;
    isLoading.value = false;
  }

  List<String>? getExpectedTimeScript() {
    LocalScriptStorage localScriptStorage = LocalScriptStorage();
    return localScriptStorage.getScriptContent();
  }

}