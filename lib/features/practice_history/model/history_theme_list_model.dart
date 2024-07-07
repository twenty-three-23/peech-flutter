import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_theme_model.dart';

part 'history_theme_list_model.g.dart';

@JsonSerializable()
class HistoryThemeListModel {

  final List<HistoryThemeModel>? themes;

  HistoryThemeListModel({this.themes});

  factory HistoryThemeListModel.fromJson(Map<String, dynamic> json) => _$HistoryThemeListModelFromJson(json);

}