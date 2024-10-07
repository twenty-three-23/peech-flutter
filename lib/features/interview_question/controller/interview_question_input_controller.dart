

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:swm_peech_flutter/features/interview_question/data_source/remote/remote_interview_question_data_source.dart';
import 'package:swm_peech_flutter/features/interview_question/model/interview_questions_list_model.dart';

import '../../common/dio/auth_dio_factory.dart';
import '../model/interview_script_model.dart';

class InterviewQuestionInputController extends GetxController {

  final interviewQuestions = InterviewQuestionsListModel(interviewQuestions: []).obs;
  var isLoading = false.obs;
  final textFieldController = TextEditingController();

  void getInterviewQuestions() async {
    try {
      isLoading.value = true;
      final remoteDataSource = RemoteInterviewQuestionDataSource(AuthDioFactory().dio);
      interviewQuestions.value = await remoteDataSource.getInterviewQuestions(InterviewScriptModel(scriptContent: textFieldController.text));
      isLoading.value = false;
    } on DioException catch (e) {
      isLoading.value = false;
      print("[getMajorList] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch (e) {
      isLoading.value = false;
      print("[getMajorList] [Exception] $e");
      if(e.toString() == "자기소개서의 주인이 아닙니다.") {
        //에러  처리
      }
      rethrow;
    }
  }

}