import 'package:json_annotation/json_annotation.dart';

part 'interview_questions_list_model.g.dart';

@JsonSerializable()
class InterviewQuestionsListModel {

  final List<String>? interviewQuestions;

  InterviewQuestionsListModel({required this.interviewQuestions});

  factory InterviewQuestionsListModel.fromJson(Map<String, dynamic> json) => _$InterviewQuestionsListModelFromJson(json);

}