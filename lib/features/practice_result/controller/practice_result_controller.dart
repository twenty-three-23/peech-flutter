import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/mock/mock_practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/practice_result_model.dart';

class PracticeResultCtr extends GetxController {

  MockPracticeResultDataSource practiceResultDataSource = MockPracticeResultDataSource();

  List<PracticeResultModel>? _practiceResult; //데이터 받아오고, 요청 보낼때만 수정
  Rx<List<TextEditingController>?> practiceResult = Rx<List<TextEditingController>?>(null);
  ScrollController scrollController = ScrollController();


  void getPracticeResult() async {
    _practiceResult = await practiceResultDataSource.getPracticeResultListTest();
    practiceResult.value = List.empty(growable: true);
    _practiceResult?.forEach((element) { practiceResult.value?.add(TextEditingController(text: element.content)); });
    practiceResult.value = practiceResult.value?.toList();
  }

  @override
  void onInit() {
    getPracticeResult();
    super.onInit();
  }

  void insertNewParagraph(int index) {
    practiceResult.value?.insert(index, TextEditingController());
    practiceResult.value = practiceResult.value?.toList(growable: true);
    if(index + 1 == practiceResult.value?.length) {
      setScrollToEnd();
    }
  }

  void removeParagraph(int index) {
    practiceResult.value?.removeAt(index);
    practiceResult.value = practiceResult.value?.toList(growable: true);
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