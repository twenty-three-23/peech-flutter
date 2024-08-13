import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_model.dart';

part 'remote_auth_token_refresh_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteAuthTokenRefreshDataSource {
  factory RemoteAuthTokenRefreshDataSource(Dio dio, {String baseUrl}) = _RemoteAuthTokenRefreshDataSource;

  @retrofit.POST("/api/v1.1/user")
  Future<AuthTokenModel> refreshToken(@retrofit.Body() Map<String, dynamic> socialLoginInfo);
}