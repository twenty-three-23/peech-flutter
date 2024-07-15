import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';

class RecodingFileUtil {
  Future<String> getFilePath() async {
    String fileName = Constants.recodingFileName;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = '$appDocPath/$fileName';
    return filePath;
  }
}