import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/theme_id_model.dart';

part 'remote_theme_save_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteThemeSaveDataSource {
  factory RemoteThemeSaveDataSource(Dio dio, {String baseUrl}) = _RemoteThemeSaveDataSource;

  @retrofit.POST('api/v1/theme')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ThemeIdModel> postTheme(@retrofit.Body() Map<String, String> themeTitle);


}