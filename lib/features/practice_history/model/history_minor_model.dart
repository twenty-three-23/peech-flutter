import 'package:json_annotation/json_annotation.dart';

part 'history_minor_model.g.dart';

@JsonSerializable()
class HistoryMinorModel {

  final int? scriptId;
  final int? minorVersion;
  final String? scriptContent;
  final String? createdAt;

  HistoryMinorModel({
    required this.scriptId,
    required this.minorVersion,
    required this.scriptContent,
    required this.createdAt
  });

  factory HistoryMinorModel.fromJson(Map<String, dynamic> json) => _$HistoryMinorModelFromJson(json);

}