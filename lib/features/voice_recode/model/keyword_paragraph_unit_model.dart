import 'package:json_annotation/json_annotation.dart';

part 'keyword_paragraph_unit_model.g.dart';

@JsonSerializable()
class KeywordParagraphUnitModel {
  List<String>? keywords;
  int? paragraphOrder;

  KeywordParagraphUnitModel({this.keywords, this.paragraphOrder});

  factory KeywordParagraphUnitModel.fromJson(Map<String, dynamic> json) => _$KeywordParagraphUnitModelFromJson(json);
  Map<String, dynamic> toJson() => _$KeywordParagraphUnitModelToJson(this);
}