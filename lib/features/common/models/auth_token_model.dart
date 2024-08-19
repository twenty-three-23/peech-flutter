import 'package:json_annotation/json_annotation.dart';

part 'auth_token_model.g.dart';

@JsonSerializable()
class AuthTokenModel {
  final String? accessToken;
  final String? refreshToken;

  AuthTokenModel({
    this.accessToken,
    this.refreshToken
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) => _$AuthTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthTokenModelToJson(this);
}