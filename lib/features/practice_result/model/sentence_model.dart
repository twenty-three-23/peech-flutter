import 'package:json_annotation/json_annotation.dart';

part 'sentence_model.g.dart';

@JsonSerializable()
class SentenceModel {

  String? sentenceId;
  int? sentenceOrder;
  String? sentenceContent;

  SentenceModel({required this.sentenceId, required this.sentenceOrder, required this.sentenceContent});

  factory SentenceModel.fromJson(Map<String, dynamic> json) => _$SentenceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SentenceModelToJson(this);
}