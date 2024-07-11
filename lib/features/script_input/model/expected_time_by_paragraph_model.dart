import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_per_paragraph_model.dart';

part 'expected_time_by_paragraph_model.g.dart';

@JsonSerializable()
class ExpectedTimeByParagraphModel {

  final int? paragraphId;
  final ExpectedTimePerParagraphModel? expectedTimePerParagraph;

  ExpectedTimeByParagraphModel({required this.paragraphId, required this.expectedTimePerParagraph});

  factory ExpectedTimeByParagraphModel.fromJson(Map<String, dynamic> json) => _$ExpectedTimeByParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpectedTimeByParagraphModelToJson(this);
}