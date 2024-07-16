import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/utils/recoding_file_util.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/mock/mock_practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/remote/remote_practice_result_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

class PracticeResultCtr extends GetxController {

  ParagraphListModel? _practiceResult; //데이터 받아오고, 요청 보낼때만 수정
  Rx<ParagraphListModel?> practiceResult = Rx<ParagraphListModel?>(null);
  ScrollController scrollController = ScrollController();


  void getPracticeResult() async {
    _practiceResult = await postPracticeResult();
    practiceResult.value = ParagraphListModel(script: _practiceResult?.script);
  }

  Future<File> getRecodingFile() async {
    String filePath = await RecodingFileUtil().getFilePath();
    return File(filePath);
  }

  Future<ParagraphListModel> postPracticeResult() async {
   try {
     print('postPracticeResult() called');
     Dio dio = Dio();
     dio.interceptors.add(AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()));
     int themeId = int.parse(LocalPracticeThemeStorage().getThemeId() ?? '0');
     int scriptId = LocalScriptStorage().getScriptId() ?? 0;
     File voiceFile = await getRecodingFile();
     RemotePracticeResultDataSource practiceResultDataSource = RemotePracticeResultDataSource(dio);
     ParagraphListModel paragraphListModel = await practiceResultDataSource.getPracticeResultList(themeId, scriptId, voiceFile);
     return paragraphListModel;
   } on DioException catch(e) {
     print("[postPracticeResult] DioException: [${e.response?.statusCode}] ${e.response?.data}");
     rethrow;
   } catch(e) {
     print("[postPracticeResult] Exception: ${e}");
     rethrow;
   }
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
    practiceResult.value?.script?.insert(index, ParagraphModel(paragraphId: null, paragraphOrder: null, time: null, isCalculated: null, sentences: [SentenceModel(sentenceId: null, sentenceOrder: 1, sentenceContent: "새 문단")]));
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

}