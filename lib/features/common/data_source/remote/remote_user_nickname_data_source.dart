import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/user_nickname_model.dart';

part 'remote_user_nickname_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserNicknameDataSource {
  factory RemoteUserNicknameDataSource(Dio dio, {String baseUrl}) = _RemoteUserNicknameDataSource;

  @GET("/api/v1.1/user")
  @Headers({'accessToken': 'true'})
  Future<UserNicknameModel> getUserNickname();
}