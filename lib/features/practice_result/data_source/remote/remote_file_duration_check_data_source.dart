import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/usage_time_check_model.dart';

part 'remote_file_duration_check_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteFileDurationCheckDataSource {
  factory RemoteFileDurationCheckDataSource(Dio dio, {String baseUrl}) = _RemoteFileDurationCheckDataSource;

  @retrofit.GET('api/v1/usage-time')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<UsageTimeCheckModel> checkFileDuration(@retrofit.Query('audio-time') int durationSeconds);
}