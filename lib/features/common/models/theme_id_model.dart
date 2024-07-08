import 'package:json_annotation/json_annotation.dart';

part 'theme_id_model.g.dart';

@JsonSerializable()
class ThemeIdModel {

  late final int themeId;

  ThemeIdModel({required this.themeId});

  Map<String, dynamic> toJson() => _$ThemeIdModelToJson(this);

  factory ThemeIdModel.fromJson(Map<String, dynamic> json) => _$ThemeIdModelFromJson(json);

}