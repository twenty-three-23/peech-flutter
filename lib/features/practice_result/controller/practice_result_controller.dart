import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/mock/mock_practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

class PracticeResultCtr extends GetxController {

  MockPracticeResultDataSource practiceResultDataSource = MockPracticeResultDataSource();

  ParagraphListModel? _practiceResult; //데이터 받아오고, 요청 보낼때만 수정
  Rx<ParagraphListModel?> practiceResult = Rx<ParagraphListModel?>(null);
  ScrollController scrollController = ScrollController();


  void getPracticeResult() async {
    _practiceResult = await practiceResultDataSource.getPracticeResultListTest();
    practiceResult.value = ParagraphListModel(script: _practiceResult?.script);
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

}