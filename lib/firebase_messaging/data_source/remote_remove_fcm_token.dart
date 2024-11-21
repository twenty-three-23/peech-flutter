import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';

part 'remote_remove_fcm_token.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteRemoveFcmToken {
  factory RemoteRemoveFcmToken(Dio dio, {String baseUrl}) = _RemoteRemoveFcmToken;

  @retrofit.DELETE('/api/v2/user/notification/token')
  @retrofit.Headers({'accessToken': 'true'})
  Future<void> deleteFcmToken(@retrofit.Body() String deviceId);
}
