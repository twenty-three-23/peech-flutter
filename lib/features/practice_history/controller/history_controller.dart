import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_refresh_intercepter.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/local/history_major_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/local/history_minor_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_major_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_theme_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_list_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_list_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_model.dart';

class HistoryCtr extends GetxController {

  Rx<HistoryThemeListModel?> themeList = Rx<HistoryThemeListModel?>(null);
  Rx<HistoryMajorListModel?> majorList = Rx<HistoryMajorListModel?>(null);
  Rx<List<HistoryMinorModel>?> minorList = Rx<List<HistoryMinorModel>?>(null);

  final historyMajorDataSource = HistoryMajorDataSource();
  final historyMinorDataSource = HistoryMinorDataSource();

  ScrollController themeScrollController = ScrollController();
  ScrollController majorScrollController = ScrollController();
  ScrollController minorScrollController = ScrollController();

  ScrollController pathScrollController = ScrollController();


  final Rx<HistoryPathModel> historyPath = Rx<HistoryPathModel>(HistoryPathModel());

  void getThemeList() async {
    try {
      Dio dio = Dio();
      dio.interceptors.addAll([
        AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()),
        AuthTokenRefreshInterceptor(localDeviceUuidStorage: LocalDeviceUuidStorage(), localUserTokenStorage: LocalUserTokenStorage())
      ]);
      final historyThemeDataSource = RemoteThemeListDataSource(dio);
      themeList.value = await getThemeListTest();
    } on DioException catch(e) {
      print("[getThemeList] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getThemeList] [Exception] $e");
      rethrow;
    }
  }

  Future<HistoryThemeListModel> getThemeListTest() async {
    Future.delayed(const Duration(seconds: 1));
    return HistoryThemeListModel(
        themes: [
          HistoryThemeModel(
              title: "test title",
              timestamp: "test timestamp",
              count: "1",
              id: "1"
          )
        ]
    );
  }

  void getMajorList() async {
    try {
      Dio dio = Dio();
      dio.interceptors.addAll([
        AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()),
        AuthTokenRefreshInterceptor(localDeviceUuidStorage: LocalDeviceUuidStorage(), localUserTokenStorage: LocalUserTokenStorage()),
      ]);
      final historyMajorDataSource = RemoteMajorListDataSource(dio);
      majorList.value = await historyMajorDataSource.getMajorList(historyPath.value.theme!);
    } on DioException catch(e) {
      print("[getMajorList] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getMajorList] [Exception] $e");
      rethrow;
    }
  }

  void getMinorList() async {
    minorList.value = await historyMinorDataSource.getMinorListTest();
  }

  void clickThemeList(int index) {
    historyPath.value.setTheme(int.parse(themeList.value?.themes?[index].id ?? '0'));
    initMajorScrollController();
  }

  void clickMajorList(int index) {
    historyPath.value.setMajor(int.parse(majorList.value?.majors?[index].scriptId ?? '0'));
    initMinorScrollController();
  }

  void clickMinorList(int index) {
    historyPath.value.setMinor(int.parse(minorList.value?[index].scriptId ?? '0'));
  }

  void setPathScrollPosToEndWithAni() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pathScrollController.hasClients) {
        pathScrollController.animateTo(
          pathScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  void addGetCurrentListListener() {
    historyPath.value.pathState.listen((newState) {
      setPathScrollPosToEndWithAni();
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

  void initMajorScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(majorScrollController.hasClients) {
        majorScrollController.jumpTo(0.0);
      }
    });
  }

  void initMinorScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(minorScrollController.hasClients) {
        minorScrollController.jumpTo(0.0);
      }
    });
  }

  void backButton(BuildContext context) {
    if(historyPath.value.pathState.value == HistoryPathState.themeList) {
      Navigator.of(context).pop();
    }
    else {
      historyPath.value.back();
    }
  }

  @override
  void onInit() {
    getThemeList();
    addGetCurrentListListener();
    super.onInit();
  }

  @override
  void onClose() {
    themeScrollController.dispose();
    majorScrollController.dispose();
    minorScrollController.dispose();
    super.onClose();
  }

}