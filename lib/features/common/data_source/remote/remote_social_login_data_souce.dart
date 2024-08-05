import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/login_token_model.dart';

part 'remote_social_login_data_souce.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteSocialLoginDataSource {
  factory RemoteSocialLoginDataSource(Dio dio, {String baseUrl}) = _RemoteSocialLoginDataSource;

  @POST("/api/v1.1/user")
  Future<LoginTokenModel> postSocialToken(@Body() Map<String, dynamic> socialLoginInfo);
}