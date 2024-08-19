import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_model.dart';

part 'auth_token_response_model.g.dart';

@JsonSerializable()
class AuthTokenResponseModel {
  final int? statusCode;
  AuthTokenModel? responseBody;

  AuthTokenResponseModel({
    this.statusCode,
    this.responseBody
  });

  factory AuthTokenResponseModel.fromJson(Map<String, dynamic> json) => _$AuthTokenResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthTokenResponseModelToJson(this);
}