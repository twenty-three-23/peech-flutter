import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';

part 'remote_script_expected_time_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteScriptExpectedTimeDataSource {
  factory RemoteScriptExpectedTimeDataSource(Dio dio, {String baseUrl}) = _RemoteScriptExpectedTimeDataSource;

  @retrofit.GET('api/v1/themes/{themeId}/scripts/{scriptId}/time')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ExpectedTimeModel> getExpectedTime(@retrofit.Path() int themeId, @retrofit.Path() int scriptId);
}