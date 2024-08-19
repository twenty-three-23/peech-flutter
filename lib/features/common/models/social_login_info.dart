import 'package:json_annotation/json_annotation.dart';

part 'social_login_info.g.dart';

@JsonSerializable()
class SocialLoginInfo {

  final String? socialToken;
  final String? authorizationServer;

  SocialLoginInfo({
    this.socialToken,
    this.authorizationServer
  });

  factory SocialLoginInfo.fromJson(Map<String, dynamic> json) => _$SocialLoginInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLoginInfoToJson(this);

}