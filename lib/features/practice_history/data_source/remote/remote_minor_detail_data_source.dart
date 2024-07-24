import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_detail_model.dart';

part 'remote_minor_detail_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMinorDetailDataSource {
  factory RemoteMinorDetailDataSource(Dio dio, {String baseUrl}) = _RemoteMinorDetailDataSource;

  @GET('api/v1/themes/{themeId}/scripts/{majorVersion}/{minorVersion}')
  Future<HistoryMinorDetailModel> getMinorDetail(@Path() int themeId, @Path() int majorVersion, @Path() int minorVersion);
}