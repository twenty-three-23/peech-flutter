import 'package:json_annotation/json_annotation.dart';

part 'history_theme_model.g.dart';

@JsonSerializable()
class HistoryThemeModel {
  final int? themeId;
  final String? themeTitle;
  final String? createdAt;
  final int? majorVersionCnt;

  HistoryThemeModel({
    this.themeId,
    this.themeTitle,
    this.createdAt,
    this.majorVersionCnt,
  });


  factory HistoryThemeModel.fromJson(Map<String, dynamic> json) => _$HistoryThemeModelFromJson(json);

}