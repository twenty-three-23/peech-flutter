import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_list_model.dart';

part 'remote_practice_editing_result_data_source.g.dart';

@RestApi(baseUrl: 'http://43.203.55.241:8080/api/v1/')
abstract class RemotePracticeEditingResultDataSource {
  factory RemotePracticeEditingResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeEditingResultDataSource;

  @POST("themes/{themeId}/scripts/{scriptId}")
  Future<ParagraphListModel> getPracticeWithScriptResultList(@Path("themeId") int themeId, @Path("scriptId") int scriptId, @Body() ReqParagraphListModel paragraphs);
}