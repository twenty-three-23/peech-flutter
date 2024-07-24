import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';

part 'remote_practice_result_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemotePracticeResultDataSource {
  factory RemotePracticeResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeResultDataSource;

  @POST("api/v1/themes/{themeId}/scripts/{scriptId}/speech/script")
  Future<ParagraphListModel> getPracticeWithScriptResultList(@Path("themeId") int themeId, @Path("scriptId") int scriptId, @Part(name: 'file') File file, @Part(name: 'time') int time);

  @POST("api/v1/themes/{themeId}/scripts/speech/script")
  Future<ParagraphListModel> getPracticeNoScriptResultList(@Path("themeId") int themeId, @Part(name: 'file') File file, @Part(name: 'time') int time);
}