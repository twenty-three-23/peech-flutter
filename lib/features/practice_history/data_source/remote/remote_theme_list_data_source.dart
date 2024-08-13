import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_list_model.dart';

part 'remote_theme_list_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteThemeListDataSource {
  factory RemoteThemeListDataSource(Dio dio, {String baseUrl}) = _RemoteThemeListDataSource;

  @retrofit.GET('api/v1/themes')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<HistoryThemeListModel> getThemeList();
}