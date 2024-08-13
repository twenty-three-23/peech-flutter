import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/remaining_time_model.dart';

part 'remote_user_audio_time_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserAudioTimeDataSource {
  factory RemoteUserAudioTimeDataSource(Dio dio, {String baseUrl}) = _RemoteUserAudioTimeDataSource;

  @retrofit.GET('api/v1/remaining-time')
  @retrofit.Headers({'accessToken': 'true'},)
  Future<RemainingTimeModel> getUserRemainingTime();

  @retrofit.GET('api/v1/max-audio-time')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<MaxAudioTimeModel> getUserMaxAudioTime();
}