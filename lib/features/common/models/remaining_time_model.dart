import 'package:json_annotation/json_annotation.dart';

part 'remaining_time_model.g.dart';

@JsonSerializable()
class RemainingTimeModel {
  final int remainingTime;

  RemainingTimeModel({
    required this.remainingTime,
  });

  factory RemainingTimeModel.fromJson(Map<String, dynamic> json) => _$RemainingTimeModelFromJson(json);
}