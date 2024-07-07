import 'package:json_annotation/json_annotation.dart';

part 'history_theme_model.g.dart';

@JsonSerializable()
class HistoryThemeModel {
  final String? title;
  final String? timestamp;
  final String? count;
  final String? id;

  HistoryThemeModel({
    this.title,
    this.timestamp,
    this.count,
    this.id
  });


  factory HistoryThemeModel.fromJson(Map<String, dynamic> json) => _$HistoryThemeModelFromJson(json);

}