import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';

part 'paragraph_list_model.g.dart';

@JsonSerializable()
class ParagraphListModel {
  int? scriptId;
  //TODO 이거 하나 다른데 data model을 분리해야 할까? (클린 아키텍처로 dto와 vo를 분리하면 해결될 문제인 것 같은데, 지금 구조에서는 어떻게 해야 할까?)
  String? totalRealTime;
  String? totalTime;
  List<ParagraphModel>? script;

  ParagraphListModel({this.scriptId, this.totalRealTime, this.totalTime, this.script});

  factory ParagraphListModel.fromJson(Map<String, dynamic> json) => _$ParagraphListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphListModelToJson(this);
}