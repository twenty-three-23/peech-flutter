import 'package:json_annotation/json_annotation.dart';
import 'req_paragraph_model.dart';

part 'req_paragraph_list_model.g.dart';

//TODO 보내는 요청과 받는 요청이 비슷한데 내부 구조는 다른 경우 파일 이름을 이런식으로 만들어도 되는지?
@JsonSerializable()
class ReqParagraphListModel {
  List<ReqParagraphModel>? paragraphs;

  ReqParagraphListModel({this.paragraphs});

  Map<String, dynamic> toJson() => _$ReqParagraphListModelToJson(this);
  factory ReqParagraphListModel.fromJson(Map<String, dynamic> json) => _$ReqParagraphListModelFromJson(json);
}