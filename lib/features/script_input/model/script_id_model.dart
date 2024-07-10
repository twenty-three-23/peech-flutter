import 'package:json_annotation/json_annotation.dart';

part 'script_id_model.g.dart';

@JsonSerializable()
class ScriptIdModel {

  final int? scriptId;

  ScriptIdModel({required this.scriptId});

  factory ScriptIdModel.fromJson(Map<String, dynamic> json) => _$ScriptIdModelFromJson(json);
}