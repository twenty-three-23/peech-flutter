import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/keyword_response_model.dart';

part 'remote_paragraph_keywords.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteParagraphKeywords {
  factory RemoteParagraphKeywords(Dio dio, {String baseUrl}) = _RemoteParagraphKeywords;

  @GET("/api/v1.1/themes/{themeId}/scripts/{scriptId}/keywords")
  @Headers({'accessToken': 'true'})
  Future<KeywordResponseModel> getKeywords(@Path("themeId") int themeId, @Path("scriptId") int scriptId);
}