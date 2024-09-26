import 'dart:io';

import 'package:swm_peech_flutter/features/common/platform/platform_record_file/record_file_on_mobile.dart'
    if (dart.library.html) 'package:swm_peech_flutter/features/common/platform/platform_record_file/record_file_on_web.dart' as record;

class PlatformRecordFile {
  // 녹음 파일을 리턴
  static Future<dynamic> getRecodingFile() async {
    return await record.getRecodingFile();
  }

  // 녹음 파일 경로 리턴
  static Future<String> getFilePath() async {
    return await record.getFilePath();
  }
}
