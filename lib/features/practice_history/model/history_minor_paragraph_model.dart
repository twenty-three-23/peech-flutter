import 'package:json_annotation/json_annotation.dart';

part 'history_minor_paragraph_model.g.dart';

@JsonSerializable()
class HistoryMinorParagraphModel {
  final String? realTimePerParagraph;
  final List<String>? sentences;

  HistoryMinorParagraphModel({this.realTimePerParagraph, this.sentences});

  factory HistoryMinorParagraphModel.fromJson(Map<String, dynamic> json) => _$HistoryMinorParagraphModelFromJson(json);

}