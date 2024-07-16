import 'package:json_annotation/json_annotation.dart';

part 'history_major_paragraph_content.g.dart';

@JsonSerializable()
class HistoryMajorParagraphContent {
  final String? paragraphContent;

  HistoryMajorParagraphContent({
    required this.paragraphContent,
  });

  factory HistoryMajorParagraphContent.fromJson(Map<String, dynamic> json) => _$HistoryMajorParagraphContentFromJson(json);

}