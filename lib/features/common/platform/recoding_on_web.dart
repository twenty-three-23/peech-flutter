import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/utils/recoding_file_util.dart';

Future<String> getRecodingFile() async {
  String audioFileURL = await RecodingFileUtil().getFilePath();

  final response = await html.HttpRequest.request(audioFileURL, responseType: 'blob');
  final html.Blob blob = response.response;

  final reader = html.FileReader();
  reader.readAsArrayBuffer(blob);
  await reader.onLoad.first;
  Uint8List voiceFileAsByte = reader.result as Uint8List;
  String voiceFile = base64Encode(voiceFileAsByte);
  return voiceFile;
}

Future<String> getFilePath() async {
  String audioFileURL = html.window.sessionStorage[Constants.webRecodingFileName] ?? "";
  return audioFileURL;
}
