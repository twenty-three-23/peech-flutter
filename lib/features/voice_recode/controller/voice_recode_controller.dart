import 'package:audio_session/audio_session.dart';
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
import 'package:swm_peech_flutter/features/common/utils/record_file_util.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
import 'package:swm_peech_flutter/features/voice_recode/data_source/remote_paragraph_keywords.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/keyword_paragraphs_model.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/keyword_response_model.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/practice_state.dart';

class VoiceRecodeCtr extends GetxController {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;

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

  Rx<bool> isRecordStopped = false.obs;

  Rx<bool> isLoading = false.obs;

  @override
  void onInit() async {
    script = LocalScriptStorage().getInputScriptContent();
    getKeywordsOnWithScript();
    getMaxAudioTime();
    _recorder = await FlutterSoundRecorder();
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

  Future<void> checkMicrophonePermission({required BuildContext? context}) async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (context != null) {
        showCommonDialog(
          context: context,
          title: '마이크 권한이 필요합니다',
          message: '마이크 권한을 허용해주세요',
          showFirstButton: false,
          secondButtonText: '확인',
          isSecondButtonToClose: true,
        );
      }
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  Future<void> _openAudioSession() async {
    await checkMicrophonePermission(context: null);
    await _recorder!.openRecorder();
    await _player!.openPlayer();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth | AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
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
        toFile: await RecordFileUtil().getFilePath(),
        codec: Codec.aacADTS,
      );
    } else {
      await _recorder!.startRecorder(
        toFile: Constants.webRecodingFileName,
        codec: Codec.pcmWebM,
      );
    }
  }

  // 녹음 자동 종료
  void checkRecodingTimeLimit(Stopwatch recodingStopWatch) {
    if (recodingStopWatch.elapsedMilliseconds >= (_maxAudioTime?.second ?? 0) * 1000) {
      _stopRecording();
      showCommonDialog(
        context: Get.context!,
        title: '녹음이 자동 종료됨',
        message: '최대 녹음 가능 시간은 ${_maxAudioTime?.text} 입니다. 제한 시간에 도달하여 녹음이 종료되었습니다.',
        showFirstButton: false,
        secondButtonText: '확인',
        isSecondButtonToClose: true,
      );
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    recodingStopWatch.value.stop();
    await _recorder!.stopRecorder();
    practiceState.value = PracticeState.end;
  }

  Future<void> _startPlaying() async {
    await _player!.startPlayer(
      fromURI: 'input the path',
      codec: Codec.aacADTS,
    );
  }

  Future<void> _stopPlaying() async {
    await _player!.stopPlayer();
  }

  void endPractice(BuildContext context) async {
    await _stopRecording();
    Navigator.pushNamed(context, '/practiceResult');
  }

  void startPracticeWithScript(BuildContext context) async {
    if (!await Permission.microphone.isGranted) {
      await checkMicrophonePermission(context: context);
      isLoading.value = true;
      await _openAudioSession();
      isLoading.value = false;
      return;
    }
    await getMaxAudioTime();
    if (_maxAudioTime == null || _maxAudioTime?.second == null) {
      throw Exception('maxAudioTime is null!');
    }
    _startRecording();
    // _stopRecodingWhenScrollIsEndListener(); //자농 녹음 중지 제거
    scriptScrollController.jumpTo(scriptScrollController.position.minScrollExtent);
    _startAutoScrollingAnimation(_getTotalExpectedTime());
  }

  void startPracticeNoScript(BuildContext context) async {
    if (!await Permission.microphone.isGranted) {
      await checkMicrophonePermission(context: context);
      isLoading.value = true;
      await _openAudioSession();
      isLoading.value = false;
      return;
    }
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

  Future<void> getKeywordsOnWithScript() async {
    try {
      // 대본 없이 녹음인 경우 키워드를 불러오지 않음
      LocalPracticeModeStorage localPracticeModeStorage = LocalPracticeModeStorage();
      PracticeMode? practiceMode = localPracticeModeStorage.getMode();
      if (practiceMode != PracticeMode.withScript) return;

      // 핵심 키워드 불러오기
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
    if (_recorder?.isStopped ?? true) {
      throw Exception("[_pauseRecoding] can't pause recorder. recorder is stopped");
      return;
    }
    await _recorder?.pauseRecorder();
  }

  Future<void> _resumeRecoding() async {
    if (_recorder?.isStopped ?? true) {
      throw Exception("[_resumeRecoding] can't resume recorder. recorder is stopped");
      return;
    }
    await _recorder?.resumeRecorder();
  }

  void _stopScrollingAnimation() {
    // 현재 애니메이션을 멈추고, 현재 위치에서 바로 멈추도록 설정
    scriptScrollController.jumpTo(scriptScrollController.offset);
  }

  void pausePracticeWithScript(BuildContext context) async {
    try {
      await _pauseRecoding();
    } catch (e) {
      practiceState.value = PracticeState.pause;
      if (context.mounted) {
        showCommonDialog(
          context: context,
          title: '중단할 수 없습니다',
          message: '녹음이 종료되어 녹음을 중단할 수 없습니다',
          showFirstButton: false,
          secondButtonText: '확인',
          isSecondButtonToClose: true,
        );
      }
      rethrow;
    }
    _stopScrollingAnimation();
    recodingStopWatch.value.stop(); // 타이머 멈추기
    _timer?.cancel(); // 타이머 객체 취소
    practiceState.value = PracticeState.pause;
  }

  void pausePracticeNoScript(BuildContext context) async {
    try {
      await _pauseRecoding();
    } catch (e) {
      if (context.mounted) {
        practiceState.value = PracticeState.pause;
        showCommonDialog(
          context: context,
          title: '중단할 수 없습니다',
          message: '녹음이 종료되어 녹음을 중단할 수 없습니다',
          showFirstButton: false,
          secondButtonText: '확인',
          isSecondButtonToClose: true,
        );
      }
      rethrow;
    }
    recodingStopWatch.value.stop(); // 타이머 멈추기
    _timer?.cancel(); // 타이머 객체 취소
    practiceState.value = PracticeState.pause;
  }

  void resumePracticeWithScript(BuildContext context) async {
    try {
      await _resumeRecoding();
    } catch (e) {
      if (context.mounted) {
        showCommonDialog(
          context: context,
          title: '이어할 수 없습니다',
          message: '녹음이 종료되어 이어서 녹음할 수 없습니다',
          showFirstButton: false,
          secondButtonText: '확인',
          isSecondButtonToClose: true,
        );
      }
      rethrow;
    }

    recodingStopWatch.value.start(); // 타이머 멈추기
    _startTimer();
    int remainingTime = _getTotalExpectedTime() - recodingStopWatch.value.elapsedMilliseconds;
    _startAutoScrollingAnimation(remainingTime);
    practiceState.value = PracticeState.recoding;
  }

  void resumePracticeNoScript(BuildContext context) async {
    try {
      await _resumeRecoding();
    } catch (e) {
      if (context.mounted) {
        showCommonDialog(
          context: context,
          title: '이어할 수 없습니다',
          message: '녹음이 종료되어 이어서 녹음할 수 없습니다',
          showFirstButton: false,
          secondButtonText: '확인',
          isSecondButtonToClose: true,
        );
      }
      rethrow;
    }
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
