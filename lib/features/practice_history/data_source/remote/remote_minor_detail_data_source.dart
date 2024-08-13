import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_detail_model.dart';

part 'remote_minor_detail_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMinorDetailDataSource {
  factory RemoteMinorDetailDataSource(Dio dio, {String baseUrl}) = _RemoteMinorDetailDataSource;

  @retrofit.GET('api/v1/themes/{themeId}/scripts/{majorVersion}/{minorVersion}')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<HistoryMinorDetailModel> getMinorDetail(@retrofit.Path() int themeId, @retrofit.Path() int majorVersion, @retrofit.Path() int minorVersion);
}