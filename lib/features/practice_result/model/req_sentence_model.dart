import 'package:json_annotation/json_annotation.dart';

part 'req_sentence_model.g.dart';

@JsonSerializable()
class ReqSentenceModel {
  String? sentenceId;
  int? sentenceOrder;
  String? sentenceContent;

  ReqSentenceModel({this.sentenceId, this.sentenceOrder, this.sentenceContent});

  Map<String, dynamic> toJson() => _$ReqSentenceModelToJson(this);
  factory ReqSentenceModel.fromJson(Map<String, dynamic> json) => _$ReqSentenceModelFromJson(json);
}