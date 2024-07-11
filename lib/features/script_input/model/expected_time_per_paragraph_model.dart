import 'package:json_annotation/json_annotation.dart';

part 'expected_time_per_paragraph_model.g.dart';

@JsonSerializable()
class ExpectedTimePerParagraphModel {

  final int? hour;
  final int? minute;
  final int? second;
  final int? nano;

  ExpectedTimePerParagraphModel({required this.hour, required this.minute, required this.second, required this.nano});

  factory ExpectedTimePerParagraphModel.fromJson(Map<String, dynamic> json) => _$ExpectedTimePerParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpectedTimePerParagraphModelToJson(this);
}