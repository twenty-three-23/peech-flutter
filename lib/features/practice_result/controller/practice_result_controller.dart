import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_result/data_source/practice_rseult_data_source.dart';
import 'package:swm_peech_flutter/features/practice_result/model/practice_result_model.dart';

class PracticeResultCtr extends GetxController {

  PracticeResultDataSource practiceResultDataSource = PracticeResultDataSource();

  Rx<List<PracticeResultModel>?> practiceResult = Rx<List<PracticeResultModel>?>(null);

  void getPracticeResult() async {
    practiceResult.value = await practiceResultDataSource.getPracticeResultListTest();
  }

  @override
  void onInit() {
    getPracticeResult();
    super.onInit();
  }

}