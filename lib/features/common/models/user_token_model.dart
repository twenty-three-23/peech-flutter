import 'package:json_annotation/json_annotation.dart';

part 'user_token_model.g.dart';

@JsonSerializable()
class UserTokenModel {
  const UserTokenModel({this.token});

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => _$UserTokenModelFromJson(json);

  final String? token;

  Map<String, dynamic> toJson() => _$UserTokenModelToJson(this);
}