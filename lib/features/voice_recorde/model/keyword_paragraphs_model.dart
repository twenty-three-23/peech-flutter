import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/voice_recorde/model/keyword_paragraph_unit_model.dart';

part 'keyword_paragraphs_model.g.dart';

@JsonSerializable()
class KeywordParagraphsModel {
  List<KeywordParagraphUnitModel>? paragraphs;

  KeywordParagraphsModel({this.paragraphs});

  factory KeywordParagraphsModel.fromJson(Map<String, dynamic> json) => _$KeywordParagraphsModelFromJson(json);
  Map<String, dynamic> toJson() => _$KeywordParagraphsModelToJson(this);
}
