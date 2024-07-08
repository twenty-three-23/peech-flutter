import 'package:json_annotation/json_annotation.dart';

part 'history_major_model.g.dart';

@JsonSerializable()
class HistoryMajorModel {

  final int? scriptId;
  final int? majorVersion;
  final String? scriptContent;
  final String? createdAt;

  HistoryMajorModel({
    required this.scriptId,
    required this.majorVersion,
    required this.scriptContent,
    required this.createdAt
  });

  factory HistoryMajorModel.fromJson(Map<String, dynamic> json) => _$HistoryMajorModelFromJson(json);

}