import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/script_input/model/full_script_time_model.dart';

part 'full_script_expected_time_model.g.dart';

@JsonSerializable()
class FullScriptExpectedTimeModel {
  final String? totalExpectedTime;
  List<FullScriptTimeModel>? script;

  FullScriptExpectedTimeModel({required this.totalExpectedTime, required this.script});

  factory FullScriptExpectedTimeModel.fromJson(Map<String, dynamic> json) => _$FullScriptExpectedTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$FullScriptExpectedTimeModelToJson(this);
}
