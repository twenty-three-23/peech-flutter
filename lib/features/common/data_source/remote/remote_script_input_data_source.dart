import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/models/script_id_model.dart';

part 'remote_script_input_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteScriptInputDataSource {
  factory RemoteScriptInputDataSource(Dio dio, {String baseUrl}) = _RemoteScriptInputDataSource;

  @retrofit.POST('api/v1/themes/{themeId}/script')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ScriptIdModel?> postScript(@retrofit.Path() int themeId, @retrofit.Body() Map<String, dynamic> body);
}