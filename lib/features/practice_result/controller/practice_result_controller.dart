import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/web_recording_file.dart';
import 'package:swm_peech_flutter/features/common/utils/recoding_file_util.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/mock/mock_practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_file_duration_check_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_practice_editing_result_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_practice_result_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_store_edited_script_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_sentence_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/store_edited_script_result.dart';
import 'package:swm_peech_flutter/features/practice_result/model/usage_time_check_model.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class PracticeResultCtr extends GetxController {

  ParagraphListModel? _practiceResult; //데이터 받아오고, 요청 보낼때만 수정
  Rx<ParagraphListModel?> practiceResult = Rx<ParagraphListModel?>(null);
  ScrollController scrollController = ScrollController();
  Rx<bool> isLoading = true.obs;

  int? resultScriptId;

  bool isEditSaved = false; //수정사항 저장했는지 여부

  bool isEdited = false;

  void getPracticeResult() async {
    isLoading.value = true;
    //TODO 이런 방식으로 밖으로 분리하기? 아니면 postPracticeResult안에 넣기? 이 방식으로 한다고 하면 두 함수 이름은 어떻게 하는게 좋을까?
    PracticeMode? practiceMode = LocalPracticeModeStorage().getMode();
    if(practiceMode == null) throw Exception("[getPracticeResult] practiceMode is null!");
    _practiceResult = await postPracticeResult(practiceMode);
    resultScriptId = _practiceResult?.scriptId;
    print("테스트: ${_practiceResult?.totalRealTime}");
    practiceResult.value = ParagraphListModel(script: _practiceResult?.script, scriptId: _practiceResult?.scriptId, totalRealTime: _practiceResult?.totalRealTime, totalTime: _practiceResult?.totalTime);
    isLoading.value = false;
  }

  Future<void> checkRecodeFileDuration() async {
    try {
      int seconds = await getRecodeSeconds();
      RemoteFileDurationCheckDataSource remoteFileDurationCheckDataSource = RemoteFileDurationCheckDataSource(AuthDioFactory().dio);
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

  Future<String> getRecodingFileOnWeb() async {

    String audioFileURL = await RecodingFileUtil().getFilePath();

    final response = await html.HttpRequest.request(audioFileURL, responseType: 'blob');
    final html.Blob blob = response.response;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(blob);
    await reader.onLoad.first;
    Uint8List voiceFileAsByte = reader.result as Uint8List;
    String voiceFile = base64Encode(voiceFileAsByte);
    return voiceFile;
  }

  Future<ParagraphListModel> postPracticeResult(PracticeMode practiceMode) async {
   try {
     print('postPracticeResult() called');
     RemotePracticeResultDataSource practiceResultDataSource = RemotePracticeResultDataSource(AuthDioFactory().dio);
     int themeId = getThemeId();

     if(!kIsWeb) {
       File voiceFile = await getRecodingFile();
       if (practiceMode == PracticeMode.withScript) {
         int? scriptId = LocalScriptStorage().getInputScriptId();
         if(scriptId == null) throw Exception("[postPracticeResult] scriptId is null!");
         ParagraphListModel paragraphListModel = await practiceResultDataSource
             .getPracticeWithScriptResultList(
             themeId, scriptId, voiceFile);
         return paragraphListModel;
       }
       else {
         ParagraphListModel paragraphListModel = await practiceResultDataSource
             .getPracticeNoScriptResultList(themeId, voiceFile);
         return paragraphListModel;
       }
     } else{
       String voiceFile = await getRecodingFileOnWeb();

       if (practiceMode == PracticeMode.withScript) {
         int? scriptId = LocalScriptStorage().getInputScriptId();
         if(scriptId == null) throw Exception("[postPracticeResult] scriptId is null!");
         ParagraphListModel paragraphListModel = await practiceResultDataSource
             .getPracticeWithScriptResultListWeb(
             themeId, scriptId, WebRecordingFile(file: voiceFile));

         return paragraphListModel;
       }
       else {
         ParagraphListModel paragraphListModel = await practiceResultDataSource
             .getPracticeNoScriptResultListWeb(themeId, WebRecordingFile(file: voiceFile));
         return paragraphListModel;
       }
     }
   } on DioException catch(e) {
     print("[postPracticeResult] DioException: [${e.response?.statusCode}] ${e.response?.data}");
     rethrow;
   } catch(e) {
     print("[postPracticeResult] Exception: ${e}");
     rethrow;
   }
  }

  Future<int> getRecodeSeconds() async {
    Duration duration = await RecodingFileUtil().getDuration();
    return duration.inSeconds;
  }

  int getThemeId() {
    int themeId = int.parse(LocalPracticeThemeStorage().getThemeId() ?? '0');
    return themeId;
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
    isEdited = true;
    practiceResult.value?.script?.insert(index, ParagraphModel(paragraphId: null, paragraphOrder: null, time: null, nowStatus: null, sentences: [SentenceModel(sentenceId: null, sentenceOrder: 1, sentenceContent: "")]));
    practiceResult.value = ParagraphListModel(script: practiceResult.value?.script, scriptId: practiceResult.value?.scriptId, totalRealTime: practiceResult.value?.totalRealTime, totalTime: practiceResult.value?.totalTime);
    if(index + 1 == practiceResult.value?.script?.length) {
      setScrollToEnd();
    }
  }

  void removeParagraph(int index) {
    isEdited = true;
    practiceResult.value?.script?.removeAt(index);
    practiceResult.value = ParagraphListModel(script: practiceResult.value?.script, scriptId: practiceResult.value?.scriptId, totalRealTime: practiceResult.value?.totalRealTime, totalTime: practiceResult.value?.totalTime);
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

  void homeBtn(BuildContext context) async {
    isLoading.value = true;
    if(isEditSaved) {
      await putEditedScript();
    }
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    isLoading.value = false;
  }

  Future<StoreEditedScriptResult> putEditedScript() async {
    try {
      int themeId = getThemeId();
      RemoteStoreEditedScriptDataSource remoteStoreEditedScriptDataSource = RemoteStoreEditedScriptDataSource(AuthDioFactory().dio);
      if(resultScriptId == null) throw Exception("[putEditedScript] resultScriptId is null!");
      return await remoteStoreEditedScriptDataSource.storeEditedScript(themeId, resultScriptId!);
    } on DioException catch(e) {
      print("[putEditedScript] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch(e) {
      print("[putEditedScript] Exception: ${e}");
      rethrow;
    }
  }

  void editingDialogCancelBtn(BuildContext context) {
    Navigator.pop(context);
  }

  void editingDialogSaveBtn(TextEditingController textEditingController, BuildContext context, int paragraphIndex, int sentenceIndex) {
    isEdited = true;
    practiceResult.value?.script?[paragraphIndex].sentences?[sentenceIndex].sentenceContent = textEditingController.text;
    practiceResult.value = ParagraphListModel(script: practiceResult.value?.script, scriptId: practiceResult.value?.scriptId, totalRealTime: practiceResult.value?.totalRealTime, totalTime: practiceResult.value?.totalTime);
    Navigator.of(context).pop();
  }

  void editingFinishBtn() async {
    try {
      isLoading.value = true;
      isEdited = false;
      isEditSaved = true;
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
      RemotePracticeEditingResultDataSource remotePracticeEditingResultDataSource = RemotePracticeEditingResultDataSource(AuthDioFactory().dio);
      int themeId = getThemeId();
      if(resultScriptId == null) throw Exception("[getEditingResult] resultScriptId is null!");
      _practiceResult = await remotePracticeEditingResultDataSource.getPracticeWithScriptResultList(themeId, resultScriptId!, reqParagraphListModel);
    } on DioException catch(e) {
      print("[getEditingResult] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch(e) {
      print("[getEditingResult] Exception: ${e}");
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