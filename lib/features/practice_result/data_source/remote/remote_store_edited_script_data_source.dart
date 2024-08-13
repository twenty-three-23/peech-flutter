import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/store_edited_script_result.dart';

part 'remote_store_edited_script_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteStoreEditedScriptDataSource {
  factory RemoteStoreEditedScriptDataSource(Dio dio, {String baseUrl}) = _RemoteStoreEditedScriptDataSource;

  @retrofit.PUT("api/v1/themes/{themeId}/scripts/{scriptId}")
  @retrofit.Headers({'accessToken' : 'true'})
  Future<StoreEditedScriptResult> storeEditedScript(@retrofit.Path("themeId") int themeId, @retrofit.Path("scriptId") int scriptId);
}