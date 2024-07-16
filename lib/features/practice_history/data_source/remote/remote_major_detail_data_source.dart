import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_paragraphs_model.dart';

part 'remote_major_detail_data_source.g.dart';

@RestApi(baseUrl: 'http://43.203.55.241:8080/api/v1/')
abstract class RemoteMajorDetailDataSource {
  factory RemoteMajorDetailDataSource(Dio dio, {String baseUrl}) = _RemoteMajorDetailDataSource;

  @GET('themes/{themeId}/scripts/{scriptId}/paragraphs')
  Future<HistoryMajorParagraphsModel> getMajorDetail(@Path('themeId') int themeId, @Path('scriptId') int scriptId);
}