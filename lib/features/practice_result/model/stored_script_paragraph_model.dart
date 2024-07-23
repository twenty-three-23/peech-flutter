import 'package:json_annotation/json_annotation.dart';

part 'stored_script_paragraph_model.g.dart';

@JsonSerializable()
class StoredScriptParagraphModel {
  String? paragraphContent;

  StoredScriptParagraphModel({this.paragraphContent});

  factory StoredScriptParagraphModel.fromJson(Map<String, dynamic> json) => _$StoredScriptParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoredScriptParagraphModelToJson(this);
}