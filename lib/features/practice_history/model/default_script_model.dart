
import 'package:json_annotation/json_annotation.dart';

part 'default_script_model.g.dart';

@JsonSerializable()
class DefaultScriptModel {

  final int? scriptId;
  final String? scriptContent;
  final DateTime? createdAt;

  DefaultScriptModel({
    this.scriptId,
    this.scriptContent,
    this.createdAt,
  });

  factory DefaultScriptModel.fromJson(Map<String, dynamic> json) => _$DefaultScriptModelFromJson(json);
}