import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/practice_result_model.dart';

class PracticeResultCtr extends GetxController {

  PracticeResultDataSource practiceResultDataSource = PracticeResultDataSource();

  List<PracticeResultModel>? _practiceResult;
  Rx<List<TextEditingController>?> practiceResult = Rx<List<TextEditingController>?>(null);


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

}