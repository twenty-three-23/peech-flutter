import 'package:json_annotation/json_annotation.dart';

part 'user_nickname_model.g.dart';

@JsonSerializable()
class UserNicknameModel {
  final String? nickName;

  UserNicknameModel({required this.nickName});

  factory UserNicknameModel.fromJson(Map<String, dynamic> json) => _$UserNicknameModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserNicknameModelToJson(this);
}