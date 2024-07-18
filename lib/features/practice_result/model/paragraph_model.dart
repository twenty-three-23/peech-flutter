import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/now_status.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

part 'paragraph_model.g.dart';

@JsonSerializable()
class ParagraphModel {
  int? paragraphId;
  int? paragraphOrder;
  String? time;
  @JsonKey(
    fromJson: _parseNowStatus
  )
  NowStatus? nowStatus;
  List<SentenceModel>? sentences;

  ParagraphModel({this.paragraphId, this.paragraphOrder, this.time, this.nowStatus, this.sentences});

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => _$ParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphModelToJson(this);

  //TODO 서버에서 enum을 주는 경우 이런 식으로 변환하는게 best?
  //TODO 이런 코드는 여기에 위치하는게 맞는가?
  static NowStatus? _parseNowStatus(String? status) {
    switch (status) {
      case null:
        return null;
      case "REALTIME":
        return NowStatus.realTime;
      case "EXPECTEDTIME":
        return NowStatus.expectedTime;
      case "REALANDEXPECTEDTIME":
        return NowStatus.realAndExpectedTime;
      default:
        throw Exception("Unknown NowStatus: $status");
    }
  }
}