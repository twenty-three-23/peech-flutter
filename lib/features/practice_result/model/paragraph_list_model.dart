import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';

part 'paragraph_list_model.g.dart';

@JsonSerializable()
class ParagraphListModel {
  List<ParagraphModel>? script;

  ParagraphListModel({required this.script});

  factory ParagraphListModel.fromJson(Map<String, dynamic> json) => _$ParagraphListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphListModelToJson(this);
}