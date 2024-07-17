import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/remaining_time_model.dart';

part 'remote_user_audio_time_data_source.g.dart';

@RestApi(baseUrl: "http://43.203.55.241:8080/api/v1/")
abstract class RemoteUserAudioTimeDataSource {
  factory RemoteUserAudioTimeDataSource(Dio dio, {String baseUrl}) = _RemoteUserAudioTimeDataSource;

  @GET('remaining-time')
  Future<RemainingTimeModel> getUserRemainingTime();

  @GET('max-audio-time')
  Future<MaxAudioTimeModel> getUserMaxAudioTime();
}