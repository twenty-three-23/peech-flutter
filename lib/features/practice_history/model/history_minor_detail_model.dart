import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_minor_paragraph_model.dart';

part 'history_minor_detail_model.g.dart';

@JsonSerializable()
class HistoryMinorDetailModel {
  final String? totalRealTime;
  final List<HistoryMinorParagraphModel>? paragraphDetails;

  HistoryMinorDetailModel({this.totalRealTime, this.paragraphDetails});

  factory HistoryMinorDetailModel.fromJson(Map<String, dynamic> json) => _$HistoryMinorDetailModelFromJson(json);
}