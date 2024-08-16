import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/keyword_paragraphs_model.dart';

part 'keyword_response_model.g.dart';

@JsonSerializable()
class KeywordResponseModel {
  int? statusCode;
  KeywordParagraphsModel? responseBody;

  KeywordResponseModel({this.statusCode, this.responseBody});

  factory KeywordResponseModel.fromJson(Map<String, dynamic> json) => _$KeywordResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$KeywordResponseModelToJson(this);
}