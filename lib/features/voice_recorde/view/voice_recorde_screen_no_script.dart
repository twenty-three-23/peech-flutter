import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';
import 'package:swm_peech_flutter/features/voice_recorde/controller/voice_recorde_controller.dart';
import 'package:swm_peech_flutter/features/voice_recorde/model/practice_state.dart';

class VoiceRecordeScreenNoScript extends StatefulWidget {
  const VoiceRecordeScreenNoScript({super.key});

  @override
  State<VoiceRecordeScreenNoScript> createState() => _VoiceRecordeScreenNoScriptState();
}

class _VoiceRecordeScreenNoScriptState extends State<VoiceRecordeScreenNoScript> with WidgetsBindingObserver {
  final VoiceRecordeCtr _controller = Get.find<VoiceRecordeCtr>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱 백그라운드로 전환
    if (state == AppLifecycleState.paused) {
      _controller.pausePracticeNoScript(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBarTitle: '음성 녹음',
      child: GetX<VoiceRecordeCtr>(
        builder: (_) => Center(
          child: _controller.isLoading.value == true
              ? const CircularProgressIndicator()
              : Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              color: _controller.practiceState.value == PracticeState.beforeToStart ||
                                      _controller.practiceState.value == PracticeState.pause ||
                                      _controller.practiceState.value == PracticeState.end
                                  ? Colors.grey
                                  : Colors.black,
                              size: 150,
                              Icons.keyboard_voice_rounded),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                size: 25,
                                color: Color(0xFFD13853),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                _controller.recodingStopWatch.value.elapsed.toString().substring(0, 10),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFD13853),
                                  height: 16 / 15,
                                ),
                              ),
                              Text(
                                ' / ${_controller.maxAudioTime.value?.text ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 140,
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              if (_controller.practiceState.value == PracticeState.beforeToStart)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ColoredButton(
                                        isLoading: RxBool(_controller.maxAudioTime.value == null),
                                        text: '시작하기',
                                        onPressed: () {
                                          _controller.startPracticeNoScript(context);
                                        },
                                        subText: RxString("(최대 ${_controller.maxAudioTime.value?.text ?? '?'})"),
                                      ),
                                    ),
                                  ],
                                )
                              else if (_controller.practiceState.value == PracticeState.recoding)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ColoredButton(
                                          text: '중지하기',
                                          onPressed: () {
                                            _controller.pausePracticeNoScript(context);
                                          }),
                                    ),
                                  ],
                                )
                              else if (_controller.practiceState.value == PracticeState.pause || _controller.practiceState.value == PracticeState.end)
                                Row(
                                  children: [
                                    GestureDetector(
                                        // 다시하기
                                        onTap: () {
                                          //_controller.resetRecoding();
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("다시 녹음하기",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 26 / 18)),
                                                  content: const Text("다시 녹음시 기존 녹음은\n저장되지 않습니다 다시 하시겠어요?",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF3B3E43), height: 24 / 16)),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ColoredButton(
                                                            text: '취소',
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            backgroundColor: const Color(0xFFF4F6FA),
                                                            textColor: const Color(0xFF3B3E43),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child: ColoredButton(
                                                            text: '확인',
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                              _controller.resetRecodingNoScript();
                                                            },
                                                            backgroundColor: const Color(0xFF3B3E43),
                                                            textColor: const Color(0xFFFFFFFF),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: const Color(0xFFFFF1F3),
                                            border: Border.all(width: 1, color: const Color(0xFFFF5468)),
                                          ),
                                          child: const Icon(
                                            Icons.refresh,
                                            color: Color(0xFF3B3E43),
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: ColoredButton(
                                          text: '이어하기',
                                          onPressed: () {
                                            _controller.resumePracticeNoScript(context);
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: ColoredButton(
                                          text: '분석받기',
                                          onPressed: () {
                                            _controller.endPractice(context);
                                          }),
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
