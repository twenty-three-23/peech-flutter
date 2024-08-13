import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_list_model.dart';

part 'remote_major_list_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteMajorListDataSource {
  factory RemoteMajorListDataSource(Dio dio, {String baseUrl}) = _RemoteMajorListDataSource;

  @retrofit.GET('api/v1/themes/{themeId}/scripts/majors')
  @retrofit.Headers({'accessToken' : 'true'})
  Future<HistoryMajorListModel> getMajorList(@retrofit.Path() int themeId);
}