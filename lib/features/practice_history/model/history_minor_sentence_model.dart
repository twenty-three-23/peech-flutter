import 'package:json_annotation/json_annotation.dart';

part 'history_minor_sentence_model.g.dart';

@JsonSerializable()
class HistoryMinorSentenceModel {
  final String? context;

  HistoryMinorSentenceModel({this.context});

  factory HistoryMinorSentenceModel.fromJson(Map<String, dynamic> json) => _$HistoryMinorSentenceModelFromJson(json);

}