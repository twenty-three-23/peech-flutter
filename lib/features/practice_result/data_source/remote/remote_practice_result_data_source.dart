import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';

part 'remote_practice_result_data_source.g.dart';

@RestApi(baseUrl: 'http://43.203.55.241:8080/api/v1/')
abstract class RemotePracticeResultDataSource {
  factory RemotePracticeResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeResultDataSource;

  @POST("themes/{themeId}/scripts/{scriptId}/speech/script")
  Future<ParagraphListModel> getPracticeWithScriptResultList(@Path("themeId") int themeId, @Path("scriptId") int scriptId, @Part(name: 'file') File file);

  @POST("themes/{themeId}/scripts/speech/script")
  Future<ParagraphListModel> getPracticeNoScriptResultList(@Path("themeId") int themeId, @Part(name: 'file') File file);
}