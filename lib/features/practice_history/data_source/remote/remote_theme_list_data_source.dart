import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_list_model.dart';

part 'remote_theme_list_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteThemeListDataSource {
  factory RemoteThemeListDataSource(Dio dio, {String baseUrl}) = _RemoteThemeListDataSource;

  @GET('api/v1/themes')
  Future<HistoryThemeListModel> getThemeList();
}