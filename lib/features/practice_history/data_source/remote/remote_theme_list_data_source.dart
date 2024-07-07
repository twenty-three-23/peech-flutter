import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_list_model.dart';

part 'remote_theme_list_data_source.g.dart';

@RestApi(baseUrl: "http://43.203.55.241:8080/api/v1/")
abstract class RemoteThemeListDataSource {
  factory RemoteThemeListDataSource(Dio dio, {String baseUrl}) = _RemoteThemeListDataSource;

  @GET('/themes')
  Future<HistoryThemeListModel> getThemeList();
}