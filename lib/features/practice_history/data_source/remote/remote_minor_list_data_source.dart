import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_list_model.dart';

part 'remote_minor_list_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMinorListDataSource {
  factory RemoteMinorListDataSource(Dio dio, {String baseUrl}) = _RemoteMinorListDataSource;

  @retrofit.GET('api/v1/themes/{themeId}/scripts/{majorVersion}/minors')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<HistoryMinorListModel> getMirorList(@retrofit.Path() int themeId, @retrofit.Path() int majorVersion);
}