import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_by_paragraph_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_by_script_model.dart';

part 'expected_time_model.g.dart';

@JsonSerializable()
class ExpectedTimeModel {

  final ExpectedTimeByScriptModel expectedTimeByScript;
  final List<ExpectedTimeByParagraphModel> expectedTimeByParagraphs;

  ExpectedTimeModel({required this.expectedTimeByScript, required this.expectedTimeByParagraphs});

  factory ExpectedTimeModel.fromJson(Map<String, dynamic> json) => _$ExpectedTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpectedTimeModelToJson(this);
}
