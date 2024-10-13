
import 'package:json_annotation/json_annotation.dart';

import 'default_script_model.dart';

part 'default_script_list_model.g.dart';

@JsonSerializable()
class DefaultScriptListModel {

  @JsonKey(name: 'scriptHistoryList')
  final List<DefaultScriptModel>? defaultScripts;

  DefaultScriptListModel({this.defaultScripts});

  factory DefaultScriptListModel.fromJson(Map<String, dynamic> json) => _$DefaultScriptListModelFromJson(json);
}