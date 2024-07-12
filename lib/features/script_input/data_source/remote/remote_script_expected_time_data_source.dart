import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';

part 'remote_script_expected_time_data_source.g.dart';

@RestApi(baseUrl: 'http://43.203.55.241:8080/api/v1/')
abstract class RemoteScriptExpectedTimeDataSource {
  factory RemoteScriptExpectedTimeDataSource(Dio dio, {String baseUrl}) = _RemoteScriptExpectedTimeDataSource;

  @GET('themes/{themeId}/scripts/{scriptId}/time')
  Future<ExpectedTimeModel> getExpectedTime(@Path() int themeId, @Path() int scriptId);
}