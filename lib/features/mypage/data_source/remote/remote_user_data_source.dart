import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/mypage/model/deleted_time_model.dart';

part 'remote_user_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserDataSource {
  factory RemoteUserDataSource(Dio dio, {String baseUrl}) = _RemoteUserDataSource;

  @retrofit.DELETE('api/v1.1/user')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<DeletedTimeModel> deleteUser();
}