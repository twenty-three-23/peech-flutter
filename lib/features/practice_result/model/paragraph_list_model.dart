import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';

part 'paragraph_list_model.g.dart';

@JsonSerializable()
class ParagraphListModel {
  int? scriptId;
  String? totalRealTime;
  String? totalTime;
  List<ParagraphModel>? script;

  ParagraphListModel({this.scriptId, this.totalRealTime, this.totalTime, this.script});

  factory ParagraphListModel.fromJson(Map<String, dynamic> json) => _$ParagraphListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphListModelToJson(this);

  String getScriptContent() {
    script?.sort((a, b) => a.paragraphOrder?.compareTo(b.paragraphOrder ?? 0) ?? 0);
    return script?.map((paragraph) => paragraph.paragraphSentence).join(" ") ?? "";
  }
}
