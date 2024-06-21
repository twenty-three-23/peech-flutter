import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';

class VoiceRecodeCtr extends GetxController {

  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  Rx<bool> isRecording = false.obs;
  Rx<bool> isPlaying = false.obs;
  final String _path = 'audio_recording.aac';

  @override
  void onInit() {
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _openAudioSession();
    super.onInit();
  }


  Future<void> _openAudioSession() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _recorder!.openRecorder();
    await _player!.openPlayer();
  }

  @override
  void onClose() {
    stopRecording();
    stopPlaying();
    _recorder!.closeRecorder();
    _player!.closePlayer();
    _recorder = null;
    _player = null;
    super.onClose();
  }

  Future<void> startRecording() async {
    isRecording.value = true;
    await _recorder!.startRecorder(
      toFile: _path,
      codec: Codec.aacADTS,
    );
  }

  Future<void> stopRecording() async {
    isRecording.value = false;
    await _recorder!.stopRecorder();
  }

  Future<void> startPlaying() async {
    isPlaying.value = true;
    await _player!.startPlayer(
      fromURI: _path,
      codec: Codec.aacADTS,
      whenFinished: () {
        isPlaying.value = false;
      },
    );
  }

  Future<void> stopPlaying() async {
    isPlaying.value = false;
    await _player!.stopPlayer();
  }

}