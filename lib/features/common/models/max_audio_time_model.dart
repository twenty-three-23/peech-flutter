import 'package:json_annotation/json_annotation.dart';

part 'max_audio_time_model.g.dart';

@JsonSerializable()
class MaxAudioTimeModel {
  final String? text;
  final int? second;

  MaxAudioTimeModel({
    this.text,
    this.second
  });

  factory MaxAudioTimeModel.fromJson(Map<String, dynamic> json) => _$MaxAudioTimeModelFromJson(json);
}