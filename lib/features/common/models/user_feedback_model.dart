import 'package:json_annotation/json_annotation.dart';

part 'user_feedback_model.g.dart';

@JsonSerializable()
class UserFeedbackModel {
  final String? message;

  UserFeedbackModel({required this.message});

  factory UserFeedbackModel.fromJson(Map<String, dynamic> json) => _$UserFeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserFeedbackModelToJson(this);
}
