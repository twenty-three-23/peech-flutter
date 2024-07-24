import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_paragraphs_model.dart';

part 'remote_major_detail_data_source.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMajorDetailDataSource {
  factory RemoteMajorDetailDataSource(Dio dio, {String baseUrl}) = _RemoteMajorDetailDataSource;

  @GET('api/v1/themes/{themeId}/scripts/{scriptId}/paragraphs')
  Future<HistoryMajorParagraphsModel> getMajorDetail(@Path('themeId') int themeId, @Path('scriptId') int scriptId);
}