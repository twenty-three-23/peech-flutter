import 'package:json_annotation/json_annotation.dart';

part 'remaining_time_model.g.dart';

@JsonSerializable()
class RemainingTimeModel {
  final String? text;
  final int? second;

  RemainingTimeModel({
    this.text,
    this.second
  });

  factory RemainingTimeModel.fromJson(Map<String, dynamic> json) => _$RemainingTimeModelFromJson(json);
}