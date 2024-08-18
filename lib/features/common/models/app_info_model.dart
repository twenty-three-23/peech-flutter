import 'package:json_annotation/json_annotation.dart';

part 'app_info_model.g.dart';

@JsonSerializable()
class AppInfoModel {
  final String appMinVersion;
  final bool appAvailable;

  AppInfoModel({
    required this.appMinVersion,
    required this.appAvailable,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => _$AppInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}