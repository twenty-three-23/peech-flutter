import 'package:json_annotation/json_annotation.dart';

part 'history_major_model.g.dart';

@JsonSerializable()
class HistoryMajorModel {

  final String? scriptId;
  final String? scriptContent;
  final String? createdAt;

  HistoryMajorModel({
    required this.scriptId,
    required this.scriptContent,
    required this.createdAt
  });

  factory HistoryMajorModel.fromJson(Map<String, dynamic> json) => _$HistoryMajorModelFromJson(json);

}