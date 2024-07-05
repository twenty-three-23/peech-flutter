import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:swm_peech_flutter/features/common/models/user_id_assign_model.dart';

part "user_id_assign_data_source.g.dart";

@RestApi(baseUrl: "http://43.203.55.241:8080/api/v1/")
abstract class UserIdAssignDataSource {
  factory UserIdAssignDataSource(Dio dio, {String baseUrl}) = _UserIdAssignDataSource;

  @POST('/user')
  Future<UserIdAssignModel> postUserId(@Body() Map<String, String> deviceId);

  @GET('/user')
  Future<UserIdAssignModel> getUserToken(@Body() Map<String, String> deviceId);
}