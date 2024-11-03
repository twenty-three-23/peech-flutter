import 'package:json_annotation/json_annotation.dart';

part 'deleted_time_model.g.dart';

@JsonSerializable()
class DeletedTimeModel {

  final DateTime? deletedTime;

  DeletedTimeModel({required this.deletedTime});

  factory DeletedTimeModel.fromJson(Map<String, dynamic> json) => _$DeletedTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeletedTimeModelToJson(this);
}