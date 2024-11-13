import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';

part 'remote_ai_analysis_result_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteAiAnalysisResultDataSource {
  factory RemoteAiAnalysisResultDataSource(Dio dio, {String baseUrl}) = _RemoteAiAnalysisResultDataSource;

  @retrofit.GET('/api/v2/script/{scriptId}/analyze-result')
  @retrofit.Headers({'accessToken': 'true'})
  Future<String?> getAnalysisResult(@retrofit.Path() int scriptId);
}
