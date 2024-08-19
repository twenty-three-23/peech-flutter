import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_list_model.dart';

part 'remote_practice_editing_result_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemotePracticeEditingResultDataSource {
  factory RemotePracticeEditingResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeEditingResultDataSource;

  @retrofit.POST("api/v1/themes/{themeId}/scripts/{scriptId}")
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ParagraphListModel> getPracticeWithScriptResultList(@retrofit.Path("themeId") int themeId, @retrofit.Path("scriptId") int scriptId, @retrofit.Body() ReqParagraphListModel paragraphs);
}