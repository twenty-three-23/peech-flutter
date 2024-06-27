import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/history_major_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/history_theme_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_model.dart';

class HistoryCtr extends GetxController {

  Rx<List<HistoryThemeModel>?> themeList = Rx<List<HistoryThemeModel>?>(null);
  Rx<List<HistoryMajorModel>?> majorList = Rx<List<HistoryMajorModel>?>(null);

  final historyThemeDataSource = HistoryThemeDataSource();
  final historyMajorDataSource = HistoryMajorDataSource();



  final Rx<HistoryPathModel> historyPath = Rx<HistoryPathModel>(HistoryPathModel());

  void getThemeList() async {
    themeList.value = await historyThemeDataSource.getThemeListTest();
  }

  void getMajorList() async {
    majorList.value = await historyMajorDataSource.getMajorListTest();
  }

  void addGetCurrentListListener() {
    historyPath.value.pathState.listen((newState) {
      switch(newState) {
        case HistoryPathState.themeList:
          getThemeList();
          break;
        case HistoryPathState.majorList:
          getMajorList();
          break;
        case HistoryPathState.minorList:
          break;
        case HistoryPathState.minorDetail:
          break;
      }
    });
  }

  @override
  void onInit() {
    getThemeList();
    addGetCurrentListListener();
    super.onInit();
  }



}