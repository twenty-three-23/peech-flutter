import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_model.dart';

part 'remote_user_additional_info_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserAdditionalInfoDataSource {
  factory RemoteUserAdditionalInfoDataSource(Dio dio, {String baseUrl}) = _RemoteUserAdditionalInfoDataSource;

  @retrofit.PATCH("/api/v1.1/user")
  @retrofit.Headers({'accessToken': 'true'})
  Future<AuthTokenModel> postUserAdditionalInfo(
    @retrofit.Query('funnel') String funnel,
    @retrofit.Body() Map<String, dynamic> userAdditionalInfo,
  );
}
