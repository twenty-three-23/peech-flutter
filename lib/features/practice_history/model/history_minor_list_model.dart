import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_model.dart';

part 'history_minor_list_model.g.dart';

@JsonSerializable()
class HistoryMinorListModel {
  final List<HistoryMinorModel>? minorScripts;

  HistoryMinorListModel({required this.minorScripts});

  factory HistoryMinorListModel.fromJson(Map<String, dynamic> json) => _$HistoryMinorListModelFromJson(json);
}