import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/history_theme_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_model.dart';

class HistoryCtr extends GetxController {

  Rx<List<HistoryThemeModel>?> themeList = Rx<List<HistoryThemeModel>?>(null);

  final historyThemeDataSource = HistoryThemeDataSource();



  final Rx<HistoryPathModel> historyPath = Rx<HistoryPathModel>(HistoryPathModel());

  void getThemeList() async {
    themeList.value = await historyThemeDataSource.getThemeListTest();
  }

  @override
  void onInit() {
    getThemeList();
    super.onInit();
  }



}