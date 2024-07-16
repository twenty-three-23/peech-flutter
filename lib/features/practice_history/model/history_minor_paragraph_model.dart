import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_sentence_model.dart';

part 'history_minor_paragraph_model.g.dart';

@JsonSerializable()
class HistoryMinorParagraphModel {
  final String? realTimePerParagraph;
  final List<HistoryMinorSentenceModel>? sentences;

  HistoryMinorParagraphModel({this.realTimePerParagraph, this.sentences});

  factory HistoryMinorParagraphModel.fromJson(Map<String, dynamic> json) => _$HistoryMinorParagraphModelFromJson(json);

}