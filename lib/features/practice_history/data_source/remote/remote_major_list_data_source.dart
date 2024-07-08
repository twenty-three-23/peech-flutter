import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_list_model.dart';

part 'remote_major_list_data_source.g.dart';

@RestApi(baseUrl: 'http://43.203.55.241:8080/api/v1/')
abstract class RemoteMajorListDataSource {
  factory RemoteMajorListDataSource(Dio dio, {String baseUrl}) = _RemoteMajorListDataSource;

  @GET('/themes/{themeId}/scripts/majors')
  Future<HistoryMajorListModel> getMajorList(@Path() int themeId);
}