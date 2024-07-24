import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_list_model.dart';

part 'remote_minor_list_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMinorListDataSource {
  factory RemoteMinorListDataSource(Dio dio, {String baseUrl}) = _RemoteMinorListDataSource;

  @GET('api/v1/themes/{themeId}/scripts/{majorVersion}/minors')
  Future<HistoryMinorListModel> getMirorList(@Path() int themeId, @Path() int majorVersion);
}