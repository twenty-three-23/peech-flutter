import 'package:json_annotation/json_annotation.dart';

part 'paragraphs_model.g.dart';

@JsonSerializable()
class ParagraphsModel {

  final List<String>? paragraps;

  ParagraphsModel({required this.paragraps});

  factory ParagraphsModel.fromJson(Map<String, dynamic> json) => _$ParagraphsModelFromJson(json);
}