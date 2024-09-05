import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/common/models/web_recording_file.dart';

part 'remote_practice_result_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemotePracticeResultDataSource {
  factory RemotePracticeResultDataSource(Dio dio, {String baseUrl}) = _RemotePracticeResultDataSource;

  @retrofit.POST("api/v1/themes/{themeId}/scripts/{scriptId}/speech/script")
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ParagraphListModel> getPracticeWithScriptResultList(@retrofit.Path("themeId") int themeId, @retrofit.Path("scriptId") int scriptId, @retrofit.Part(name: 'file') File file);

  @retrofit.POST("api/v1/themes/{themeId}/scripts/speech/script")
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ParagraphListModel> getPracticeNoScriptResultList(@retrofit.Path("themeId") int themeId, @retrofit.Part(name: 'file') File file);

  @retrofit.POST("web/api/v1/themes/{themeId}/scripts/{scriptId}/speech/script")
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ParagraphListModel> getPracticeWithScriptResultListWeb(@retrofit.Path("themeId") int themeId, @retrofit.Path("scriptId") int scriptId, @retrofit.Body() WebRecordingFile webRecordingBody);

  @retrofit.POST("web/api/v1/themes/{themeId}/scripts/speech/script")
  @retrofit.Headers({'accessToken' : 'true'})
  Future<ParagraphListModel> getPracticeNoScriptResultListWeb(@retrofit.Path("themeId") int themeId, @retrofit.Body() WebRecordingFile webRecordingBody);
}