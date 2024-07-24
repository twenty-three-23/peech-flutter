import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/remaining_time_model.dart';

part 'remote_user_audio_time_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserAudioTimeDataSource {
  factory RemoteUserAudioTimeDataSource(Dio dio, {String baseUrl}) = _RemoteUserAudioTimeDataSource;

  @GET('api/v1/remaining-time')
  Future<RemainingTimeModel> getUserRemainingTime();

  @GET('api/v1/max-audio-time')
  Future<MaxAudioTimeModel> getUserMaxAudioTime();
}