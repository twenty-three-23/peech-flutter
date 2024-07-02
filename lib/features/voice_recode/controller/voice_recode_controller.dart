import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:swm_peech_flutter/features/common/data_source/local_script_storage.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/practice_state.dart';

class VoiceRecodeCtr extends GetxController {

  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  Rx<bool> isRecording = false.obs;
  Rx<bool> isPlaying = false.obs;
  final String _path = 'audio_recording.aac';
  late final List<String>? script;
  ScrollController scriptScrollController = ScrollController();
  Rx<PracticeState> practiceState = PracticeState.BEFORETOSTART.obs;
  final GlobalKey scriptListViewKey = GlobalKey();  // GlobalKey 추가
  Rx<double> scriptListViewSize = Rx<double>(0.0);
  Rx<Stopwatch> recodingStopWatch = Stopwatch().obs;
  Timer? _timer;

  @override
  void onInit() {
    script = LocalScriptStorage().getScript();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _openAudioSession();
    _getListViewHeight();
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
    _timer?.cancel();
    super.onClose();
  }

  Future<void> startRecording() async {
    practiceState.value = PracticeState.RECODING;
    recodingStopWatch.value.reset();
    recodingStopWatch.value.start();

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      recodingStopWatch.refresh();
    });

    await _recorder!.startRecorder(
      toFile: _path,
      codec: Codec.aacADTS,
    );
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    practiceState.value = PracticeState.ENDRECODING;
    _timer?.cancel();
    recodingStopWatch.value.stop();
    await _recorder!.stopRecorder();
    isRecording.value = false;
  }

  Future<void> startPlaying() async {
    await _player!.startPlayer(
      fromURI: _path,
      codec: Codec.aacADTS,
      whenFinished: () {
        isPlaying.value = false;
      },
    );
    isPlaying.value = true;
  }

  Future<void> stopPlaying() async {
    await _player!.stopPlayer();
    isPlaying.value = false;
  }

  void endPractice(BuildContext context) {
    stopRecording();
    Navigator.pushNamed(context, '/practiceResult');
  }

  void startPracticeWithScript() async {
    await startRecording();
    await startAutoScrolling();
    // await stopRecording();
  }

  void startPracticeNoScript() {
    startRecording();
  }

  Future<void> startAutoScrolling() async {
    scriptScrollController.jumpTo(scriptScrollController.position.minScrollExtent);
    await scriptScrollController.animateTo(
      scriptScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 10000),
      curve: Curves.linear,
    );
  }

  void _getListViewHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = scriptListViewKey.currentContext?.findRenderObject() as RenderBox;
      scriptListViewSize.value = renderBox.size.height;
    });

  }


}