import 'package:json_annotation/json_annotation.dart';

part 'store_edited_script_result.g.dart';

@JsonSerializable()
class StoreEditedScriptResult {

  int? scriptId;

  StoreEditedScriptResult({this.scriptId});

  factory StoreEditedScriptResult.fromJson(Map<String, dynamic> json) => _$StoreEditedScriptResultFromJson(json);

  Map<String, dynamic> toJson() => _$StoreEditedScriptResultToJson(this);
}