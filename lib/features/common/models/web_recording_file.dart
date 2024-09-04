import 'package:json_annotation/json_annotation.dart';

part 'web_recording_file.g.dart';

@JsonSerializable()
class WebRecordingFile {
  final String file;

  WebRecordingFile({
    required this.file,
  });

  factory WebRecordingFile.fromJson(Map<String, dynamic> json) => _$WebRecordingFileFromJson(json);
  Map<String, dynamic> toJson() => _$WebRecordingFileToJson(this);
}