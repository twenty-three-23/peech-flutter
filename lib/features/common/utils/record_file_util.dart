import 'package:flutter_sound/flutter_sound.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_record_file/platform_record_file.dart';

class RecordFileUtil {
  FlutterSoundPlayer player = FlutterSoundPlayer();

  RecordFileUtil() {
    player.openPlayer();
  }

  Future<String> getFilePath() async {
    return PlatformRecordFile.getFilePath();
  }

  Future<dynamic> getRecodingFile() async {
    return PlatformRecordFile.getRecodingFile();
  }

  Future<Duration> getDuration() async {
    String path = await getFilePath();
    Duration? duration = await player.startPlayer(
      fromURI: path,
    );
    player.stopPlayer();
    if (duration == null) throw Exception("[getDuration] duration is null!");
    print("[getDuration] duration: $duration");
    return duration;
  }
}
