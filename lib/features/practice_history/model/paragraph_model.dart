import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/now_status.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

part 'paragraph_model.g.dart';

@JsonSerializable()
class ParagraphModel {
  int? paragraphOrder;
  String? measurementResult;
  String? time;
  String? paragraph;

  ParagraphModel({this.paragraphOrder, this.time, this.paragraph, this.measurementResult});

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => _$ParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphModelToJson(this);
}
