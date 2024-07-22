import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auto_token_register_intercepter.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/debug_interceptor.dart';
import 'package:swm_peech_flutter/features/common/utils/recoding_file_util.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/mock/mock_practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_file_duration_check_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_practice_editing_result_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_practice_result_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_sentence_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/usage_time_check_model.dart';

class PracticeResultCtr extends GetxController {

  ParagraphListModel? _practiceResult; //데이터 받아오고, 요청 보낼때만 수정
  Rx<ParagraphListModel?> practiceResult = Rx<ParagraphListModel?>(null);
  ScrollController scrollController = ScrollController();
  Rx<bool> isLoading = true.obs;


  void getPracticeResult() async {
    isLoading.value = true;
    await checkRecodeFileDuration();
    //TODO 이런 방식으로 밖으로 분리하기? 아니면 postPracticeResult안에 넣기? 이 방식으로 한다고 하면 두 함수 이름은 어떻게 하는게 좋을까?
    PracticeMode? practiceMode = LocalPracticeModeStorage().getMode();
    if(practiceMode == null) throw Exception("[getPracticeResult] practiceMode is null!");
    _practiceResult = await postPracticeResult(practiceMode);
    practiceResult.value = ParagraphListModel(script: _practiceResult?.script);
    isLoading.value = false;
  }

  Future<void> checkRecodeFileDuration() async {
    try {
      Duration duration = await RecodingFileUtil().getDuration();
      int seconds = duration.inSeconds;
      Dio dio = Dio();
      dio.interceptors.addAll([
        AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()),
        AutoTokenRegisterIntercepter(localDeviceUuidStorage: LocalDeviceUuidStorage()),
        DebugIntercepter(),
      ]);
      RemoteFileDurationCheckDataSource remoteFileDurationCheckDataSource = RemoteFileDurationCheckDataSource(dio);
      UsageTimeCheckModel usageTimeCheck = await remoteFileDurationCheckDataSource.checkFileDuration(seconds);
      print("응답: ${usageTimeCheck.message}");
    } on DioException catch(e) {
      print("[checkRecodeFileDuration] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch(e) {
      print("[checkRecodeFileDuration] Exception: ${e}");
      rethrow;
    }
  }

  Future<File> getRecodingFile() async {
    String filePath = await RecodingFileUtil().getFilePath();
    return File(filePath);
  }

  Future<ParagraphListModel> postPracticeResult(PracticeMode practiceMode) async {
   try {
     print('postPracticeResult() called');
     Dio dio = Dio();
     dio.interceptors.add(AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()));
     RemotePracticeResultDataSource practiceResultDataSource = RemotePracticeResultDataSource(dio);

     int themeId = getThemeId();
     if(practiceMode == PracticeMode.withScript) {
       int scriptId = getScriptId();
       File voiceFile = await getRecodingFile();
       ParagraphListModel paragraphListModel = await practiceResultDataSource.getPracticeWithScriptResultList(themeId, scriptId, voiceFile);
       return paragraphListModel;
     }
     else {
       File voiceFile = await getRecodingFile();
       ParagraphListModel paragraphListModel = await practiceResultDataSource.getPracticeNoScriptResultList(themeId, voiceFile);
       return paragraphListModel;
     }


   } on DioException catch(e) {
     print("[postPracticeResult] DioException: [${e.response?.statusCode}] ${e.response?.data}");
     rethrow;
   } catch(e) {
     print("[postPracticeResult] Exception: ${e}");
     rethrow;
   }
  }

  int getThemeId() {
    int themeId = int.parse(LocalPracticeThemeStorage().getThemeId() ?? '0');
    return themeId;
  }

  int getScriptId() {
    int scriptId = LocalScriptStorage().getScriptId() ?? 0;
    return scriptId;
  }

  Future<ParagraphListModel> postPracticeResultTest() async {
    MockPracticeResultDataSource practiceResultDataSource = MockPracticeResultDataSource();
    return await practiceResultDataSource.getPracticeResultListTest();
  }

  @override
  void onInit() {
    getPracticeResult();
    super.onInit();
  }

  void insertNewParagraph(int index) {
    practiceResult.value?.script?.insert(index, ParagraphModel(paragraphId: null, paragraphOrder: null, time: null, nowStatus: null, sentences: [SentenceModel(sentenceId: null, sentenceOrder: 1, sentenceContent: "")]));
    practiceResult.value = ParagraphListModel(script: practiceResult.value?.script);
    if(index + 1 == practiceResult.value?.script?.length) {
      setScrollToEnd();
    }
  }

  void removeParagraph(int index) {
    practiceResult.value?.script?.removeAt(index);
    practiceResult.value = ParagraphListModel(script: practiceResult.value?.script);
  }

  void setScrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void homeButton(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  }

  void editingDialogCancelBtn(BuildContext context) {
    Navigator.pop(context);
  }

  void editingDialogSaveBtn(TextEditingController textEditingController, BuildContext context, int paragraphIndex, int sentenceIndex) {
    practiceResult.value?.script?[paragraphIndex].sentences?[sentenceIndex].sentenceContent = textEditingController.text;
    practiceResult.value = ParagraphListModel(script: practiceResult.value?.script);
    Navigator.of(context).pop();
  }

  void editingFinishBtn() async {
    try {
      isLoading.value = true;
      _practiceResult = practiceResult.value;
      await getEditingResult();
      practiceResult.value = _practiceResult;
      isLoading.value = false;
    } catch(e) {
      isLoading.value = false;
      print("[editingFinishBtn] Exception: ${e}");
      rethrow;
    }
  }

  Future<void> getEditingResult() async {
    try {
      ReqParagraphListModel reqParagraphListModel = convertReqParagraphModel(_practiceResult);
      Dio dio = Dio();
      dio.interceptors.addAll([
        AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()),
        DebugIntercepter(),
      ]);
      RemotePracticeEditingResultDataSource remotePracticeEditingResultDataSource = RemotePracticeEditingResultDataSource(dio);
      int themeId = getThemeId();
      int scriptId = getScriptId();
      _practiceResult = await remotePracticeEditingResultDataSource.getPracticeWithScriptResultList(themeId, scriptId, reqParagraphListModel);
    } on DioException catch(e) {
      print("[editingFinishBtn] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch(e) {
      print("[editingFinishBtn] Exception: ${e}");
      rethrow;
    }
  }

  ReqParagraphListModel convertReqParagraphModel(ParagraphListModel? paragraphListModel) {
    ReqParagraphListModel reqParagraphsModel = ReqParagraphListModel(paragraphs: []);
    for(int index = 0; index < (_practiceResult?.script?.length ?? 0); index++) {
      ParagraphModel? element = _practiceResult?.script?[index];
      List<ReqSentenceModel> sentences = [];
      for(int sentenceIndex = 0; sentenceIndex < (element?.sentences?.length ?? 0); sentenceIndex++) {
        SentenceModel? sentenceElement = element?.sentences?[sentenceIndex];
        sentences.add(ReqSentenceModel(
            sentenceId: sentenceElement?.sentenceId,
            sentenceOrder: sentenceIndex,
            sentenceContent: sentenceElement?.sentenceContent
        ));
      }
      reqParagraphsModel.paragraphs?.add(
          ReqParagraphModel(
              paragraphId: element?.paragraphId,
              paragraphOrder: index,
              sentences: sentences
          )
      );
    }
    return reqParagraphsModel;
  }

}