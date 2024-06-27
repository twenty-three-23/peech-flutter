import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/history_major_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/history_minor_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/history_theme_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_model.dart';

class HistoryCtr extends GetxController {

  Rx<List<HistoryThemeModel>?> themeList = Rx<List<HistoryThemeModel>?>(null);
  Rx<List<HistoryMajorModel>?> majorList = Rx<List<HistoryMajorModel>?>(null);
  Rx<List<HistoryMinorModel>?> minorList = Rx<List<HistoryMinorModel>?>(null);

  final historyThemeDataSource = HistoryThemeDataSource();
  final historyMajorDataSource = HistoryMajorDataSource();
  final historyMinorDataSource = HistoryMinorDataSource();



  final Rx<HistoryPathModel> historyPath = Rx<HistoryPathModel>(HistoryPathModel());

  void getThemeList() async {
    themeList.value = await historyThemeDataSource.getThemeListTest();
  }

  void getMajorList() async {
    majorList.value = await historyMajorDataSource.getMajorListTest();
  }

  void getMinorList() async {
    minorList.value = await historyMinorDataSource.getMinorListTest();
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
          getMinorList();
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