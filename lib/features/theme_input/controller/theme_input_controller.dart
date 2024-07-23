import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_refresh_intercepter.dart';
import 'package:swm_peech_flutter/features/common/models/theme_id_model.dart';
import 'package:swm_peech_flutter/features/theme_input/data_source/remote/remote_theme_save_data_source.dart';
import '../../common/data_source/local/local_practice_mode_storage.dart';

class ThemeInputCtr extends GetxController {
  String? _theme;

  Rx<bool> isLoading = false.obs;

  void updateTheme(String? newTheme) {
    _theme = newTheme;
  }

  Future<void> saveTheme() async {
    if(_theme == null || _theme == "") {
      throw Exception("error: theme is null or blank");
    }
    await LocalPracticeThemeStorage().setThemeText(_theme);
    final ThemeIdModel themeIdModel = await getThemeId(_theme ?? "");
    await LocalPracticeThemeStorage().setThemeId(themeIdModel.themeId.toString());
  }

  Future<void> saveThemeTest() async {
    await LocalPracticeThemeStorage().setThemeText("test theme");
    await LocalPracticeThemeStorage().setThemeId("1");
  }

  Future<ThemeIdModel> getThemeId(String theme) async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()));
      dio.interceptors.add(AuthTokenRefreshInterceptor(localDeviceUuidStorage: LocalDeviceUuidStorage(), localUserTokenStorage: LocalUserTokenStorage()));
      final remoteThemeSaveDataSource = RemoteThemeSaveDataSource(dio);
      final ThemeIdModel themeIdModel = await remoteThemeSaveDataSource.postTheme({"themeTitle": theme});
      print("테마id: ${themeIdModel.themeId}");
      return themeIdModel;
    } on DioException catch(e) {
      print("status: ${e.response?.statusCode}, message: ${e.response?.data["message"]}");
      throw(Exception("[remoteThemeSaveDataSource.postTheme()] Bad Request"));
    }
  }

  void finishButton(BuildContext context) async {
    isLoading.value = true;
    await saveTheme();
    if(context.mounted) {
      if (LocalPracticeModeStorage().getMode() == PracticeMode.withScript) {
        Navigator.pushNamed(context, '/scriptInput/input');
        isLoading.value = false;
      }
      else if (LocalPracticeModeStorage().getMode() == PracticeMode.noScript) {
        Navigator.pushNamed(context, '/voiceRecodeNoScript');
        isLoading.value = false;
      }
    }
  }
}