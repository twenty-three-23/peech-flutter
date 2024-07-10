import 'package:json_annotation/json_annotation.dart';

part 'paragraphs_model.g.dart';

@JsonSerializable()
class ParagraphsModel {

  final List<String>? paragraphs;

  ParagraphsModel({required this.paragraphs});

  factory ParagraphsModel.fromJson(Map<String, dynamic> json) => _$ParagraphsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphsModelToJson(this);
}