import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

part 'paragraph_model.g.dart';

@JsonSerializable()
class ParagraphModel {
  int? paragraphId;
  int? paragraphOrder;
  String? time;
  bool? isCalculated;
  List<SentenceModel>? sentences;

  ParagraphModel({required this.paragraphId, required this.paragraphOrder, required this.time, required this.isCalculated, required this.sentences});

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => _$ParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphModelToJson(this);
}