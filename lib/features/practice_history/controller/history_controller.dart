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
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_major_detail_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_major_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_minor_detail_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_minor_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/data_source/remote/remote_theme_list_data_source.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_list_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_paragraphs_model.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_detail_model.dart';
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

  Rx<HistoryMajorParagraphsModel?> majorDetail = Rx<HistoryMajorParagraphsModel?>(null);
  HistoryMajorParagraphsModel? _majorDetail;

  Rx<HistoryMinorDetailModel?> minorDetail = Rx<HistoryMinorDetailModel?>(null);
  HistoryMinorDetailModel? _minorDetail;

  Future<void> getMajorDetail(int themeId, int scriptId) async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(DebugIntercepter());
      final remoteMajorDetailDataSource = RemoteMajorDetailDataSource(dio);
      _majorDetail = await remoteMajorDetailDataSource.getMajorDetail(themeId, scriptId);
    } on DioException catch(e) {
      print("[getMajorDetail] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getMajorDetail] [Exception] $e");
      rethrow;
    }
  }

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
      print("메이저 개수: ${majorList.value?.majorScripts?.length}");
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

  void getMinorDetail() async {
    try { //TODO try-catch 구문을 api 호출시마다 매번 넣어줘야하는가? 깔끔하게 해결하는 방법이 없을까?
      Dio dio = Dio();
      dio.interceptors.addAll([
        DebugIntercepter()
      ]);
      final remoteMinorDetailDataSource = RemoteMinorDetailDataSource(dio);
      final themeId = historyPath.value.theme ?? 0;
      final majorVersion = historyPath.value.major ?? 0;
      final minorVersion = historyPath.value.minor ?? 0;
      _minorDetail = await remoteMinorDetailDataSource.getMinorDetail(themeId, majorVersion, minorVersion);
      minorDetail.value = _minorDetail; //TODO ui 업데이트를 get함수 내에서 처리해주는게 맞는가? get은 가져오는역할만 하는줄 알았는데 ui가 업데이트되는 사이드 이펙트가 생길수도?
    } on DioException catch(e) {
      print("[getMinorDetail] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getMinorDetail] [Exception] $e");
      rethrow;
    }
}

  void clickThemeList(int index) {
    print("선택 테마: ${themeList.value?.themes?[index].themeId}");
    historyPath.value.setTheme(themeList.value?.themes?[index].themeId);
    initMajorScrollController();
  }

  void clickMajorList(int index) {
    historyPath.value.setMajor(majorList.value?.majorScripts?[index].majorVersion ?? 0);
    initMinorScrollController();
  }

  void clickMinorList(int index) {
    historyPath.value.setMinor(minorList.value?.minorScripts?[index].minorVersion ?? 0);
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
    getThemeList();
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
          getMinorDetail();
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

  void majorDetailButton(BuildContext context) async {
    majorDetail.value = null;
    Navigator.pushNamed(context, '/historyMajorDetail');
    int themeId = historyPath.value.theme ?? 0;
    int scriptId = majorList.value?.majorScripts?.firstWhere((element) => element.majorVersion == historyPath.value.major).scriptId ?? 0;
    await getMajorDetail(themeId, scriptId); //TODO 이 방식과 _majorDetail = getMajorDetail(themeId, scriptId); 방식 중 옳은 것.
    majorDetail.value = _majorDetail; //TODO 변수를 매번 화면에 보이는 것과 데이터를 가지고 있는 것으로 나눠야 하는가? 그냥 바로 majorDetail = getMajorDetail(themeId, scriptId); 해도 되는 것 아닌가?
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