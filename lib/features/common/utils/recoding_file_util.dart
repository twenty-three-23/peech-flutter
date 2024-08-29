import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class RecodingFileUtil {
  //TODO 1. 이런식으로 해도 괜찮을까?
  //TODO 2. 녹음 시작, 종료 등의 기능도 여기다가 구현해 두고 사용해야 하나?

  FlutterSoundPlayer player = FlutterSoundPlayer();

  RecodingFileUtil() {
    player.openPlayer();
  }

  Future<String> getFilePath() async {
    if (!kIsWeb) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String fileName = Constants.recodingFileName;
      String filePath = '$appDocPath/$fileName';
      return filePath;
    } else {
      String audioFileURL =
          html.window.sessionStorage[Constants.webRecodingFileName] ?? "";
      return audioFileURL;
    }
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
