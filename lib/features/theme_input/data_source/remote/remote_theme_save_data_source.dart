import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/models/theme_id_model.dart';

part 'remote_theme_save_data_source.g.dart';

@RestApi(baseUrl: "http://43.203.55.241:8080/api/v1/")
abstract class RemoteThemeSaveDataSource {
  factory RemoteThemeSaveDataSource(Dio dio, {String baseUrl}) = _RemoteThemeSaveDataSource;

  @POST('/theme')
  Future<ThemeIdModel> postTheme(@Body() Map<String, String> themeTitle);


}