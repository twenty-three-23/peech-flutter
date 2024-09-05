import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_response_model.dart';

part 'remote_social_login_data_souce.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteSocialLoginDataSource {
  factory RemoteSocialLoginDataSource(Dio dio, {String baseUrl}) = _RemoteSocialLoginDataSource;

  @retrofit.POST("/api/v1.1/user")
  Future<AuthTokenResponseModel> postSocialToken(
    @retrofit.Query('funnel') String funnel,
    @retrofit.Body() Map<String, dynamic> socialLoginInfo,
  );
}
