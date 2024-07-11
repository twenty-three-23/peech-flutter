import 'package:json_annotation/json_annotation.dart';

part 'expected_time_by_script_model.g.dart';

@JsonSerializable()
class ExpectedTimeByScriptModel {

  final int? hour;
  final int? minute;
  final int? second;
  final int? nano;

  ExpectedTimeByScriptModel({required this.hour, required this.minute, required this.second, required this.nano});

  factory ExpectedTimeByScriptModel.fromJson(Map<String, dynamic> json) => _$ExpectedTimeByScriptModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpectedTimeByScriptModelToJson(this);
}