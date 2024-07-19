import 'package:json_annotation/json_annotation.dart';

part 'script_input_paragraphs_model.g.dart';

@JsonSerializable()
class ScriptInputParagraphsModel {

  final List<String>? paragraphs;

  ScriptInputParagraphsModel({required this.paragraphs});

  factory ScriptInputParagraphsModel.fromJson(Map<String, dynamic> json) => _$ParagraphsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphsModelToJson(this);
}