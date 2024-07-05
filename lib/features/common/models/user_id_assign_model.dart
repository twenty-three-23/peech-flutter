import 'package:json_annotation/json_annotation.dart';

part 'user_id_assign_model.g.dart';

@JsonSerializable()
class UserIdAssignModel {
  const UserIdAssignModel({this.token});

  factory UserIdAssignModel.fromJson(Map<String, dynamic> json) => _$UserIdAssignModelFromJson(json);

  final String? token;

  Map<String, dynamic> toJson() => _$UserIdAssignModelToJson(this);
}