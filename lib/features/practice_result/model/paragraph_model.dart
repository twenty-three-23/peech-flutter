import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/now_status.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

part 'paragraph_model.g.dart';

@JsonSerializable()
class ParagraphModel {
  int? paragraphId;
  int? paragraphOrder;
  String? measurementResult;
  String? time;
  @JsonKey(fromJson: _parseNowStatus)
  NowStatus? nowStatus;
  List<SentenceModel>? sentences;

  ParagraphModel({this.paragraphId, this.paragraphOrder, this.time, this.nowStatus, this.sentences});

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => _$ParagraphModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParagraphModelToJson(this);

  String get paragraphSentence {
    sentences?.sort((a, b) => a.sentenceOrder?.compareTo(b.sentenceOrder ?? 0) ?? 0);
    return sentences?.map((sentence) => sentence.sentenceContent).join(" ") ?? "";
  }

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
