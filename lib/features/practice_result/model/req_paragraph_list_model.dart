import 'package:json_annotation/json_annotation.dart';
import 'req_paragraph_model.dart';

part 'req_paragraph_list_model.g.dart';

@JsonSerializable()
class ReqParagraphListModel {
  List<ReqParagraphModel>? paragraphs;

  ReqParagraphListModel({this.paragraphs});

  Map<String, dynamic> toJson() => _$ReqParagraphListModelToJson(this);
  factory ReqParagraphListModel.fromJson(Map<String, dynamic> json) => _$ReqParagraphListModelFromJson(json);
}
