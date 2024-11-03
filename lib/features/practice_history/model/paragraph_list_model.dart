import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_history/model/paragraph_model.dart';

part 'paragraph_list_model.g.dart';

@JsonSerializable()
class ParagraphListModel {
  String? totalRealTime;
  List<ParagraphModel>? script;

  ParagraphListModel({this.totalRealTime, this.script});

  factory ParagraphListModel.fromJson(Map<String, dynamic> json) => _$ParagraphListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphListModelToJson(this);
}
