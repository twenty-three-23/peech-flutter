import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/controllers/review_controller.dart';

import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_review_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/web_recording_file.dart';
import 'package:swm_peech_flutter/features/common/utils/record_file_util.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
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

class PracticeResultCtr extends GetxController {
  final reviewController = Get.find<ReviewController>();

  ParagraphListModel? _practiceResult; //데이터 받아오고, 요청 보낼때만 수정
  Rx<ParagraphListModel?> practiceResult = Rx<ParagraphListModel?>(null);
  ScrollController scrollController = ScrollController();
  Rx<bool> isLoading = true.obs;

  int? resultScriptId;

  bool isEditSaved = false; //수정사항 저장했는지 여부

  bool isEdited = false;

  void getPracticeResult(BuildContext context) async {
    isLoading.value = true;
    PracticeMode? practiceMode = LocalPracticeModeStorage().getMode();
    if (practiceMode == null) throw Exception("[getPracticeResult] practiceMode is null!");
    _practiceResult = await postPracticeResult(context, practiceMode);
    resultScriptId = _practiceResult?.scriptId;
    print("테스트: ${_practiceResult?.totalRealTime}");
    practiceResult.value = ParagraphListModel(
        script: _practiceResult?.script,
        scriptId: _practiceResult?.scriptId,
        totalRealTime: _practiceResult?.totalRealTime,
        totalTime: _practiceResult?.totalTime);
    isLoading.value = false;
  }

  Future<ParagraphListModel> postPracticeResult(BuildContext context, PracticeMode practiceMode) async {
    try {
      print('postPracticeResult() called');
      RemotePracticeResultDataSource practiceResultDataSource = RemotePracticeResultDataSource(AuthDioFactory().dio);
      int themeId = getThemeId();

      dynamic voiceFile = await RecordFileUtil().getRecodingFile();

      if (!kIsWeb) {
        ParagraphListModel paragraphListModel = await practiceResultDataSource.getPracticeNoScriptResultList(themeId, voiceFile as File);
        return paragraphListModel;
      } else {
        ParagraphListModel paragraphListModel =
            await practiceResultDataSource.getPracticeNoScriptResultListWeb(themeId, WebRecordingFile(file: voiceFile as String));
        return paragraphListModel;
      }
    } on DioException catch (e) {
      print("[postPracticeResult] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      if (context.mounted) {
        showCommonDialog(
          context: context,
          title: '서버 에러',
          message: '서버 에러가 발생했습니다. 잠시 후 다시 시도해주세요.\n\n에러 메시지: ${e.response?.data['message']}',
          showFirstButton: false,
          isSecondButtonToClose: true,
        );
      }
      rethrow;
    } catch (e) {
      print("[postPracticeResult] Exception: ${e}");
      showCommonDialog(
        context: context,
        title: '서버 에러',
        message: '클라이언트 에러가 발생했습니다. 잠시 후 다시 시도해주세요',
        showFirstButton: false,
        isSecondButtonToClose: true,
      );
      rethrow;
    }
  }

  Future<void> checkRecordeFileDuration() async {
    try {
      int seconds = await getRecordeSeconds();
      RemoteFileDurationCheckDataSource remoteFileDurationCheckDataSource = RemoteFileDurationCheckDataSource(AuthDioFactory().dio);
      UsageTimeCheckModel usageTimeCheck = await remoteFileDurationCheckDataSource.checkFileDuration(seconds);
      print("응답: ${usageTimeCheck.message}");
    } on DioException catch (e) {
      print("[checkRecordeFileDuration] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("[checkRecordeFileDuration] Exception: ${e}");
      rethrow;
    }
  }

  Future<int> getRecordeSeconds() async {
    Duration duration = await RecordFileUtil().getDuration();
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

  void insertNewParagraph(int index) {
    isEdited = true;
    practiceResult.value?.script?.insert(
        index,
        ParagraphModel(
            paragraphId: null,
            paragraphOrder: null,
            time: null,
            nowStatus: null,
            sentences: [SentenceModel(sentenceId: null, sentenceOrder: 1, sentenceContent: "")]));
    practiceResult.value = ParagraphListModel(
        script: practiceResult.value?.script,
        scriptId: practiceResult.value?.scriptId,
        totalRealTime: practiceResult.value?.totalRealTime,
        totalTime: practiceResult.value?.totalTime);
    if (index + 1 == practiceResult.value?.script?.length) {
      setScrollToEnd();
    }
  }

  void removeParagraph(int index) {
    isEdited = true;
    practiceResult.value?.script?.removeAt(index);
    practiceResult.value = ParagraphListModel(
        script: practiceResult.value?.script,
        scriptId: practiceResult.value?.scriptId,
        totalRealTime: practiceResult.value?.totalRealTime,
        totalTime: practiceResult.value?.totalTime);
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
    if (isEditSaved) {
      await putEditedScript();
    }
    reviewRequired(context);
    Navigator.pushNamedAndRemoveUntil(context, "/root", (route) => false);
    isLoading.value = false;
  }

  void reviewRequired(BuildContext context) {
    LocalReviewStorage localReviewStorage = LocalReviewStorage();
    bool isReviewSubmitted = localReviewStorage.getIsReviewSubmitted() ?? false;
    print("[isReviewSubmitted]: $isReviewSubmitted");
    if (!isReviewSubmitted) {
      reviewController.reviewRequired(context: context, endFunction: () => localReviewStorage.setIsReviewSubmitted(true));
    }
  }

  Future<StoreEditedScriptResult> putEditedScript() async {
    try {
      int themeId = getThemeId();
      RemoteStoreEditedScriptDataSource remoteStoreEditedScriptDataSource = RemoteStoreEditedScriptDataSource(AuthDioFactory().dio);
      if (resultScriptId == null) throw Exception("[putEditedScript] resultScriptId is null!");
      return await remoteStoreEditedScriptDataSource.storeEditedScript(themeId, resultScriptId!);
    } on DioException catch (e) {
      print("[putEditedScript] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch (e) {
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
    practiceResult.value = ParagraphListModel(
        script: practiceResult.value?.script,
        scriptId: practiceResult.value?.scriptId,
        totalRealTime: practiceResult.value?.totalRealTime,
        totalTime: practiceResult.value?.totalTime);
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
    } catch (e) {
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
      if (resultScriptId == null) throw Exception("[getEditingResult] resultScriptId is null!");
      _practiceResult = await remotePracticeEditingResultDataSource.getPracticeWithScriptResultList(themeId, resultScriptId!, reqParagraphListModel);
    } on DioException catch (e) {
      print("[getEditingResult] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("[getEditingResult] Exception: ${e}");
      rethrow;
    }
  }

  ReqParagraphListModel convertReqParagraphModel(ParagraphListModel? paragraphListModel) {
    ReqParagraphListModel reqParagraphsModel = ReqParagraphListModel(paragraphs: []);
    for (int index = 0; index < (_practiceResult?.script?.length ?? 0); index++) {
      ParagraphModel? element = _practiceResult?.script?[index];
      List<ReqSentenceModel> sentences = [];
      for (int sentenceIndex = 0; sentenceIndex < (element?.sentences?.length ?? 0); sentenceIndex++) {
        SentenceModel? sentenceElement = element?.sentences?[sentenceIndex];
        sentences
            .add(ReqSentenceModel(sentenceId: sentenceElement?.sentenceId, sentenceOrder: sentenceIndex, sentenceContent: sentenceElement?.sentenceContent));
      }
      reqParagraphsModel.paragraphs?.add(ReqParagraphModel(paragraphId: element?.paragraphId, paragraphOrder: index, sentences: sentences));
    }
    return reqParagraphsModel;
  }

  String getScriptContent() {
    return practiceResult.value?.getScriptContent() ?? "";
  }
}
