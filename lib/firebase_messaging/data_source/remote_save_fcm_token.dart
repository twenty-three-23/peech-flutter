import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/firebase_messaging/model/save_token_request_model.dart';

part 'remote_save_fcm_token.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteSaveFcmToken {
  factory RemoteSaveFcmToken(Dio dio, {String baseUrl}) = _RemoteSaveFcmToken;

  @retrofit.PUT('/api/v2/user/notification/token')
  @retrofit.Headers({'accessToken': 'true'})
  Future<void> putFcmToken(@retrofit.Body() SaveTokenRequestModel saveTokenRequestModel);
}
