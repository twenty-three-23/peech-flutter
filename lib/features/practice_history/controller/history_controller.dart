import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_refresh_intercepter.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/debug_interceptor.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/mock/mock_history_major_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/mock/mock_history_minor_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/mock/mock_history_theme_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_major_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_minor_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_theme_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_list_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_list_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_list_model.dart';

class HistoryCtr extends GetxController {

  Rx<HistoryThemeListModel?> themeList = Rx<HistoryThemeListModel?>(null);
  Rx<HistoryMajorListModel?> majorList = Rx<HistoryMajorListModel?>(null);
  Rx<HistoryMinorListModel?> minorList = Rx<HistoryMinorListModel?>(null);


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
        AuthTokenRefreshInterceptor(localDeviceUuidStorage: LocalDeviceUuidStorage(), localUserTokenStorage: LocalUserTokenStorage()),
        DebugIntercepter(),
      ]);
      final historyThemeDataSource = RemoteThemeListDataSource(dio);
      themeList.value = await historyThemeDataSource.getThemeList();
    } on DioException catch(e) {
      print("[getThemeList] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getThemeList] [Exception] $e");
      rethrow;
    }
  }

  void getThemeListTest() async {
    final historyThemeDataSource = MockHistoryThemeDataSource();
    themeList.value = await historyThemeDataSource.getThemeListTest();
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
      print("메이저 리스트 개수: ${majorList.value?.majorScripts?.length}");
    } on DioException catch(e) {
      print("[getMajorList] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getMajorList] [Exception] $e");
      rethrow;
    }
  }

  void getMajorListTest() async {
    final historyMajorDataSource = MockHistoryMajorDataSource();
    majorList.value = await historyMajorDataSource.getMajorListTest();
  }

  void getMinorList() async {
    try {
      Dio dio = Dio();
      dio.interceptors.addAll([
        AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()),
        AuthTokenRefreshInterceptor(localDeviceUuidStorage: LocalDeviceUuidStorage(), localUserTokenStorage: LocalUserTokenStorage()),
      ]);
      final historyMinorDataSource = RemoteMinorListDataSource(dio);
      minorList.value = await historyMinorDataSource.getMirorList(historyPath.value.theme ?? 0, historyPath.value.major ?? 0);
      print("마이너 리스트 개수: ${minorList.value?.minorScripts?.length}");
    } on DioException catch(e) {
      print("[getMinorList] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getMinorList] [Exception] $e");
      rethrow;
    }
  }

  void getMinorListTest() async {
    final historyMinorDataSource = MockHistoryMinorDataSource();
    minorList.value = await historyMinorDataSource.getMinorListTest();
  }

  void clickThemeList(int index) {
    print("선택 테마: ${themeList.value?.themes?[index].themeId}");
    historyPath.value.setTheme(themeList.value?.themes?[index].themeId);
    initMajorScrollController();
  }

  void clickMajorList(int index) {
    historyPath.value.setMajor(majorList.value?.majorScripts?[index].scriptId ?? 0);
    initMinorScrollController();
  }

  void clickMinorList(int index) {
    historyPath.value.setMinor(minorList.value?.minorScripts?[index].scriptId ?? 0);
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

  //TODO 테스트 코드 제거하기
  void addGetCurrentListListener() {
    getThemeListTest();
    // getThemeList();
    historyPath.value.pathState.listen((newState) {
      setPathScrollPosToEndWithAni();
      switch(newState) {
        case HistoryPathState.themeList:
          getMajorListTest();
          // getThemeList();
          break;
        case HistoryPathState.majorList:
          getMajorListTest();
          // getMajorList();
          break;
        case HistoryPathState.minorList:
          getMinorListTest();
          // getMinorList();
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