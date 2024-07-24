import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/store_edited_script_result.dart';

part 'remote_store_edited_script_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteStoreEditedScriptDataSource {
  factory RemoteStoreEditedScriptDataSource(Dio dio, {String baseUrl}) = _RemoteStoreEditedScriptDataSource;

  @PUT("api/v1/themes/{themeId}/scripts/{scriptId}")
  Future<StoreEditedScriptResult> storeEditedScript(@Path("themeId") int themeId, @Path("scriptId") int scriptId);
}