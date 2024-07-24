import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/user_token_model.dart';

part "remote_user_id_assign_data_source.g.dart";

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserTokenDataSource {
  factory RemoteUserTokenDataSource(Dio dio, {String baseUrl}) = _RemoteUserTokenDataSource;

  @POST('api/v1/user')
  Future<UserTokenModel> postUserId(@Body() Map<String, String> deviceId);

  @GET('api/v1/user')
  Future<UserTokenModel> getUserToken(@Body() Map<String, String> deviceId);
}