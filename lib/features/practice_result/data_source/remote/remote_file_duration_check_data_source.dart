import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/practice_result/model/usage_time_check_model.dart';

part 'remote_file_duration_check_data_source.g.dart';

@RestApi(baseUrl: 'http://43.203.55.241:8080/api/v1/')
abstract class RemoteFileDurationCheckDataSource {
  factory RemoteFileDurationCheckDataSource(Dio dio, {String baseUrl}) = _RemoteFileDurationCheckDataSource;

  @GET('usage-time')
  Future<UsageTimeCheckModel> checkFileDuration(@Query('audio-time') int durationSeconds);
}