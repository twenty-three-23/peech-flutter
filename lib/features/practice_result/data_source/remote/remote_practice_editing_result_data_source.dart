import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/req_paragraph_list_model.dart';

part 'remote_practice_editing_result_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemotePracticeEditingResultDataSource {
  factory RemotePracticeEditingResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeEditingResultDataSource;

  @POST("api/v1/themes/{themeId}/scripts/{scriptId}")
  Future<ParagraphListModel> getPracticeWithScriptResultList(@Path("themeId") int themeId, @Path("scriptId") int scriptId, @Body() ReqParagraphListModel paragraphs);
}