import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_audio_time_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/utils/recoding_file_util.dart';
import 'package:swm_peech_flutter/features/voice_recode/data_source/remote_paragraph_keywords.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/keyword_paragraphs_model.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/keyword_response_model.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/practice_state.dart';

class VoiceRecodeCtr extends GetxController {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  Rx<bool> isRecording = false.obs;
  Rx<bool> isPlaying = false.obs;

  late final List<String>? script;
  ScrollController scriptScrollController = ScrollController();
  Rx<PracticeState> practiceState = PracticeState.beforeToStart.obs;
  final GlobalKey scriptListViewKey = GlobalKey(); // GlobalKey 추가
  Rx<double> scriptListViewSize = Rx<double>(0.0);
  Rx<Stopwatch> recodingStopWatch = Stopwatch().obs;
  Timer? _timer;
  Rx<KeywordParagraphsModel?> keywords = KeywordParagraphsModel().obs;

  MaxAudioTimeModel? _maxAudioTime;
  Rx<MaxAudioTimeModel?> maxAudioTime = Rx<MaxAudioTimeModel?>(null);

  Rx<String?> promptSelectedOption = RxString('대본');
  final List<String> promptOptions = ['대본', '핵심 키워드', '전부 숨기기'];

  @override
  void onInit() async {
    script = LocalScriptStorage().getInputScriptContent();
    getKeywords();
    getMaxAudioTime();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _openAudioSession();
    _getListViewHeightOnWithScript();
    super.onInit();
  }

  Future<void> getMaxAudioTime() async {
    try {
      _maxAudioTime = null;
      maxAudioTime.value = null;
      RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource = RemoteUserAudioTimeDataSource(AuthDioFactory().dio);
      _maxAudioTime = await remoteUserAudioTimeDataSource.getUserMaxAudioTime();
      maxAudioTime.value = _maxAudioTime;
    } on DioException catch (e) {
      print("[getRemainingTime] DioException: [${e.response?.statusCode}] ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("[getRemainingTime] Exception: ${e}");
      rethrow;
    }
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
    _stopRecording();
    _stopPlaying();
    _recorder!.closeRecorder();
    _player!.closePlayer();
    _recorder = null;
    _player = null;
    _timer?.cancel();
    super.onClose();
  }

  Future<void> _startRecording() async {
    practiceState.value = PracticeState.recoding;
    recodingStopWatch.value.reset();
    recodingStopWatch.value.start();

    _startTimer();

    if (!kIsWeb) {
      await _recorder!.startRecorder(
        toFile: await RecodingFileUtil().getFilePath(),
        codec: Codec.aacADTS,
      );
    } else {
      await _recorder!.startRecorder(
        toFile: Constants.webRecodingFileName,
        codec: Codec.pcmWebM,
      );
    }
    isRecording.value = true;
  }

  void checkRecodingTimeLimit(Stopwatch recodingStopWatch) {
    if (recodingStopWatch.elapsedMilliseconds >= (_maxAudioTime?.second ?? 0) * 1000) {
      _stopRecording();
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    recodingStopWatch.value.stop();
    await _recorder!.stopRecorder();
    isRecording.value = false;
  }

  Future<void> _startPlaying() async {
    await _player!.startPlayer(
      fromURI: 'input the path',
      codec: Codec.aacADTS,
      whenFinished: () {
        isPlaying.value = false;
      },
    );
    isPlaying.value = true;
  }

  Future<void> _stopPlaying() async {
    await _player!.stopPlayer();
    isPlaying.value = false;
  }

  void endPractice(BuildContext context) async {
    await _stopRecording();
    Navigator.pushNamed(context, '/practiceResult');
  }

  void startPracticeWithScript() async {
    await getMaxAudioTime();
    if (_maxAudioTime == null || _maxAudioTime?.second == null) {
      throw Exception('maxAudioTime is null!');
    }
    _startRecording();
    // _stopRecodingWhenScrollIsEndListener(); //자농 녹음 중지 제거
    scriptScrollController.jumpTo(scriptScrollController.position.minScrollExtent);
    _startAutoScrollingAnimation(_getTotalExpectedTime());
  }

  void startPracticeNoScript() async {
    await getMaxAudioTime();
    if (_maxAudioTime == null || _maxAudioTime?.second == null) {
      throw Exception('maxAudioTime is null!');
    }
    _startRecording();
  }

  void stopPracticeWithScript() {
    // _stopRecodingWhenScrollIsEndListener()에 의해 자동으로 음성 녹음 중지
    // 스크롤 위치가 마지막으로 설정되어 _startAutoScrollingAnimation() 자동 종료
    _setScrollingToEnd();
    _stopRecording();
  }

  void stopPracticeNoScript() {
    _stopRecording();
  }

  void _stopRecodingWhenScrollIsEndListener() {
    scriptScrollController.addListener(() {
      if (scriptScrollController.position.pixels == scriptScrollController.position.maxScrollExtent) {
        _setScrollingToEnd();
        _stopRecording();
        scriptScrollController.removeListener(() {});
      }
    });
  }

  Future<void> _startAutoScrollingAnimation(int milliSec) async {
    await scriptScrollController.animateTo(
      scriptScrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: milliSec),
      curve: Curves.linear,
    );
  }

  void _setScrollingToEnd() {
    scriptScrollController.jumpTo(scriptScrollController.position.maxScrollExtent);
  }

  void _getListViewHeightOnWithScript() {
    LocalPracticeModeStorage localPracticeModeStorage = LocalPracticeModeStorage();
    PracticeMode? practiceMode = localPracticeModeStorage.getMode();
    if (practiceMode != PracticeMode.withScript) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = scriptListViewKey.currentContext?.findRenderObject() as RenderBox;
      scriptListViewSize.value = renderBox.size.height;
    });
  }

  void resetRecodingWithScript() {
    practiceState.value = PracticeState.beforeToStart;
    recodingStopWatch.value.reset();
    _recorder?.stopRecorder();
    scriptScrollController.jumpTo(scriptScrollController.position.minScrollExtent);
  }

  void resetRecodingNoScript() {
    practiceState.value = PracticeState.beforeToStart;
    _recorder?.stopRecorder();
    recodingStopWatch.value.reset();
  }

  Future<void> getKeywords() async {
    try {
      int themeId = getThemeId();
      int scriptId = getScriptId();
      RemoteParagraphKeywords remoteParagraphKeywords = RemoteParagraphKeywords(AuthDioFactory().dio);
      KeywordResponseModel keywordResponseModel = await remoteParagraphKeywords.getKeywords(themeId, scriptId);
      keywords.value = KeywordParagraphsModel(paragraphs: keywordResponseModel.responseBody?.paragraphs);
      keywords.refresh();
    } on DioException catch (e) {
      print("[getKeywords] DioException: [${e.response?.statusCode}] ${e.response?.data}");
    } catch (e) {
      print("[getKeywords] Exception: ${e}");
    }
  }

  int getThemeId() {
    LocalPracticeThemeStorage localPracticeThemeStorage = LocalPracticeThemeStorage();
    return int.parse(localPracticeThemeStorage.getThemeId() ?? '0');
  }

  int getScriptId() {
    LocalScriptStorage localScriptStorage = LocalScriptStorage();
    return localScriptStorage.getInputScriptId() ?? 0;
  }

  Future<void> _pauseRecoding() async {
    await _recorder?.pauseRecorder();
  }

  Future<void> _resumeRecoding() async {
    await _recorder?.resumeRecorder();
  }

  void _stopScrollingAnimation() {
    // 현재 애니메이션을 멈추고, 현재 위치에서 바로 멈추도록 설정
    scriptScrollController.jumpTo(scriptScrollController.offset);
  }

  void pausePracticeWithScript() async {
    await _pauseRecoding();
    _stopScrollingAnimation();
    recodingStopWatch.value.stop(); // 타이머 멈추기
    _timer?.cancel(); // 타이머 객체 취소
    practiceState.value = PracticeState.pause;
  }

  void pausePracticeNoScript() async {
    await _pauseRecoding();
    recodingStopWatch.value.stop(); // 타이머 멈추기
    _timer?.cancel(); // 타이머 객체 취소
    practiceState.value = PracticeState.pause;
  }

  void resumePracticeWithScript() async {
    await _resumeRecoding();
    recodingStopWatch.value.start(); // 타이머 멈추기
    _startTimer();
    int remainingTime = _getTotalExpectedTime() - recodingStopWatch.value.elapsedMilliseconds;
    _startAutoScrollingAnimation(remainingTime);
    practiceState.value = PracticeState.recoding;
  }

  void resumePracticeNoScript() async {
    await _resumeRecoding();
    recodingStopWatch.value.start(); // 타이머 멈추기
    _startTimer();
    practiceState.value = PracticeState.recoding;
  }

  int _getTotalExpectedTime() {
    int totalExpectedTime = LocalScriptStorage().getInputScriptTotalExpectedTimeMilli() ?? 0;
    totalExpectedTime += (script?.length ?? 0) * 1000; //문단당 1초로 숨 쉬는 시간 계산
    return totalExpectedTime;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      recodingStopWatch.refresh();
      checkRecodingTimeLimit(recodingStopWatch.value);
    });
  }
}
