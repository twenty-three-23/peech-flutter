import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/usage_time_check_model.dart';

part 'remote_file_duration_check_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteFileDurationCheckDataSource {
  factory RemoteFileDurationCheckDataSource(Dio dio, {String baseUrl}) = _RemoteFileDurationCheckDataSource;

  @GET('api/v1/usage-time')
  Future<UsageTimeCheckModel> checkFileDuration(@Query('audio-time') int durationSeconds);
}