import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/app_info_model.dart';

part 'remote_app_info_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteAppInfoDataSource {
  factory RemoteAppInfoDataSource(Dio dio, {String baseUrl}) = _RemoteAppInfoDataSource;

  @GET("/app/info")
  Future<AppInfoModel> getAppInfo();
}