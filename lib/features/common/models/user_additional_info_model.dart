import 'package:json_annotation/json_annotation.dart';

part 'user_additional_info_model.g.dart';

@JsonSerializable()
class UserAdditionalInfoModel {
  final String? firstName;
  final String? lastName;
  final String? nickName;
  final String? birth;
  final String? gender;

  UserAdditionalInfoModel({
    this.firstName,
    this.lastName,
    this.nickName,
    this.birth,
    this.gender
  });

  factory UserAdditionalInfoModel.fromJson(Map<String, dynamic> json) => _$UserAdditionalInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserAdditionalInfoModelToJson(this);
}