import 'package:json_annotation/json_annotation.dart';
import 'req_sentence_model.dart';

part 'req_paragraph_model.g.dart';

@JsonSerializable()
class ReqParagraphModel {
  int? paragraphId;
  int? paragraphOrder;
  List<ReqSentenceModel>? sentences;

  ReqParagraphModel({this.paragraphId, this.paragraphOrder, this.sentences});

  Map<String, dynamic> toJson() => _$ReqParagraphModelToJson(this);
  factory ReqParagraphModel.fromJson(Map<String, dynamic> json) => _$ReqParagraphModelFromJson(json);
}