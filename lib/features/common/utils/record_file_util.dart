import 'package:flutter_sound/flutter_sound.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_record_file/platform_record_file.dart';

class RecordFileUtil {
  //TODO 1. 이런식으로 해도 괜찮을까?
  //TODO 2. 녹음 시작, 종료 등의 기능도 여기다가 구현해 두고 사용해야 하나?

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

  //TODO 이런식으로 구하는게 맞나?
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
