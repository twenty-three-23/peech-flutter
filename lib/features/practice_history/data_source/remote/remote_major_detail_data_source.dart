import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_paragraphs_model.dart';

part 'remote_major_detail_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMajorDetailDataSource {
  factory RemoteMajorDetailDataSource(Dio dio, {String baseUrl}) = _RemoteMajorDetailDataSource;

  @retrofit.GET('api/v1/themes/{themeId}/scripts/{scriptId}/paragraphs')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<HistoryMajorParagraphsModel> getMajorDetail(@retrofit.Path('themeId') int themeId, @retrofit.Path('scriptId') int scriptId);
}