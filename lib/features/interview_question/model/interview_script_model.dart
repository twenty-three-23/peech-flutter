import 'package:json_annotation/json_annotation.dart';

part 'interview_script_model.g.dart';

@JsonSerializable()
class InterviewScriptModel {

  final String scriptContent;

  InterviewScriptModel({required this.scriptContent});

  // fromJson 메서드 (역직렬화)
  factory InterviewScriptModel.fromJson(Map<String, dynamic> json) => _$InterviewScriptModelFromJson(json);

  // toJson 메서드 (직렬화)
  Map<String, dynamic> toJson() => _$InterviewScriptModelToJson(this);
}