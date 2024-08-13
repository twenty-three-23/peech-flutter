import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_model.g.dart';

@JsonSerializable()
class RefreshTokenModel {
  final String? refreshToken;

  RefreshTokenModel({required this.refreshToken});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => _$RefreshTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenModelToJson(this);
}