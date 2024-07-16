import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_paragraph_content.dart';

part 'history_major_paragraphs_model.g.dart';

@JsonSerializable()
class HistoryMajorParagraphsModel {
  final List<HistoryMajorParagraphContent>? paragraphs;

  HistoryMajorParagraphsModel({
    required this.paragraphs,
  });

  factory HistoryMajorParagraphsModel.fromJson(Map<String, dynamic> json) => _$HistoryMajorParagraphsModelFromJson(json);
}