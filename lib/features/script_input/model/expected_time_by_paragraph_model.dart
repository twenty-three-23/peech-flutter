import 'package:json_annotation/json_annotation.dart';

part 'expected_time_by_paragraph_model.g.dart';

@JsonSerializable()
class ExpectedTimeByParagraphModel {

  final int? paragraphId;
  final String? expectedTimePerParagraph;

  ExpectedTimeByParagraphModel({required this.paragraphId, required this.expectedTimePerParagraph});

  factory ExpectedTimeByParagraphModel.fromJson(Map<String, dynamic> json) => _$ExpectedTimeByParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpectedTimeByParagraphModelToJson(this);
}