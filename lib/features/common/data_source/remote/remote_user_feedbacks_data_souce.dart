import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';

part 'remote_user_feedbacks_data_souce.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteUserFeedbacksDataSource {
  factory RemoteUserFeedbacksDataSource(Dio dio, {String baseUrl}) = _RemoteUserFeedbacksDataSource;

  @POST("api/v1.1/users/feedbacks")
  @Headers({'accessToken': 'true'})
  Future<void> sendUserFeedback(@Body() Map<String, dynamic> userFeedback);
}
