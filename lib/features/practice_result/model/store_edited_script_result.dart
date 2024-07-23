import 'package:json_annotation/json_annotation.dart';
import 'package:swm_peech_flutter/features/practice_result/model/stored_script_paragraph_model.dart';

part 'store_edited_script_result.g.dart';

@JsonSerializable()
class StoreEditedScriptResult {

  int? scriptId;
  List<StoredScriptParagraphModel>? paragraphs;

  StoreEditedScriptResult({this.scriptId, this.paragraphs});

  factory StoreEditedScriptResult.fromJson(Map<String, dynamic> json) => _$StoreEditedScriptResultFromJson(json);

  Map<String, dynamic> toJson() => _$StoreEditedScriptResultToJson(this);
}