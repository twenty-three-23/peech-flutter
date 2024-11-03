import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/paragraph_list_model.dart';

part 'remote_practice_result_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemotePracticeResultDataSource {
  factory RemotePracticeResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeResultDataSource;

  @retrofit.GET('api/v2/theme/{themeId}/scripts/{scriptId}')
  @retrofit.Headers({'accessToken': 'true'})
  Future<ParagraphListModel> getPracticeResult(@retrofit.Path('themeId') int themeId, @retrofit.Path('scriptId') int scriptId);
}
