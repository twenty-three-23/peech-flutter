import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/utils/recoding_file_util.dart';

Future<File> getRecodingFile() async {
  String filePath = await RecodingFileUtil().getFilePath();
  return File(filePath);
}

Future<String> getFilePath() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  String fileName = Constants.recodingFileName;
  String filePath = '$appDocPath/$fileName';
  return filePath;
}