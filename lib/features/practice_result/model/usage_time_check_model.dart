import 'package:json_annotation/json_annotation.dart';

part 'usage_time_check_model.g.dart';

@JsonSerializable()
class UsageTimeCheckModel {
  final String? message;

  UsageTimeCheckModel({this.message});

  factory UsageTimeCheckModel.fromJson(Map<String, dynamic> json) => _$UsageTimeCheckModelFromJson(json);

}