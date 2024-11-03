import 'package:json_annotation/json_annotation.dart';

part 'full_script_model.g.dart';

@JsonSerializable()
class FullScriptModel {
  final String fullScript;

  FullScriptModel({required this.fullScript});

  factory FullScriptModel.fromJson(Map<String, dynamic> json) => _$FullScriptModelFromJson(json);
  Map<String, dynamic> toJson() => _$FullScriptModelToJson(this);
}
