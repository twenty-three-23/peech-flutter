import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_model.dart';

part 'history_major_list_model.g.dart';

@JsonSerializable()
class HistoryMajorListModel {

  final List<HistoryMajorModel>? majors;

  HistoryMajorListModel({required this.majors});

  factory HistoryMajorListModel.fromJson(Map<String, dynamic> json) => _$HistoryMajorListModelFromJson(json);

}