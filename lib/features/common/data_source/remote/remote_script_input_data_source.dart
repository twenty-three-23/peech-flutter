import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/script_id_model.dart';

part 'remote_script_input_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteScriptInputDataSource {
  factory RemoteScriptInputDataSource(Dio dio, {String baseUrl}) = _RemoteScriptInputDataSource;

  @POST('api/v1/themes/{themeId}/script')
  Future<ScriptIdModel?> postScript(@Path() int themeId, @Body() Map<String, dynamic> body);
}