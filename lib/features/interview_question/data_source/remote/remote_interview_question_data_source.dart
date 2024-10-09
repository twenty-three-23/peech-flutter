import 'package:retrofit/retrofit.dart' as retrofit;

import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/interview_question/model/interview_questions_list_model.dart';
import 'package:swm_peech_flutter/features/interview_question/model/interview_script_model.dart';

import '../../../common/constant/constants.dart';

part 'remote_interview_question_data_source.g.dart';

@retrofit.RestApi(baseUrl: Constants.baseUrl)
abstract class RemoteInterviewQuestionDataSource {
  factory RemoteInterviewQuestionDataSource(Dio dio, {String baseUrl}) = _RemoteInterviewQuestionDataSource;

  @retrofit.POST('api/v2/interview-questions')
  @retrofit.Headers({'accessToken' : 'true' ,  'Content-Type': 'application/json'})
  Future<InterviewQuestionsListModel> getInterviewQuestions(@retrofit.Body() InterviewScriptModel scriptContent);
}