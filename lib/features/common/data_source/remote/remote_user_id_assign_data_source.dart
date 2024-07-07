import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:swm_peech_flutter/features/common/models/user_token_model.dart';

part "remote_user_id_assign_data_source.g.dart";

@RestApi(baseUrl: "http://43.203.55.241:8080/api/v1/")
abstract class RemoteUserTokenDataSource {
  factory RemoteUserTokenDataSource(Dio dio, {String baseUrl}) = _RemoteUserTokenDataSource;

  @POST('/user')
  Future<UserTokenModel> postUserId(@Body() Map<String, String> deviceId);

  @GET('/user')
  Future<UserTokenModel> getUserToken(@Body() Map<String, String> deviceId);
}