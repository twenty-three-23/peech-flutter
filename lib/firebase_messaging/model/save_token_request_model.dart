import 'package:json_annotation/json_annotation.dart';

part 'save_token_request_model.g.dart';

@JsonSerializable()
class SaveTokenRequestModel {
  String deviceId;
  String fcmToken;

  SaveTokenRequestModel({required this.deviceId, required this.fcmToken});

  factory SaveTokenRequestModel.fromJson(Map<String, dynamic> json) => _$SaveTokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaveTokenRequestModelToJson(this);
}
