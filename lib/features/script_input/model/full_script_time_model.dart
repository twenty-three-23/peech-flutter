import 'package:json_annotation/json_annotation.dart';

part 'full_script_time_model.g.dart';

@JsonSerializable()
class FullScriptTimeModel {
  final String? time;
  String? paragraph;

  FullScriptTimeModel({required this.time, required this.paragraph});

  factory FullScriptTimeModel.fromJson(Map<String, dynamic> json) => _$FullScriptTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$FullScriptTimeModelToJson(this);
}
