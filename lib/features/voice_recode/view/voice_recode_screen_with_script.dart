import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';
import 'package:swm_peech_flutter/features/voice_recode/controller/voice_recode_controller.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/practice_state.dart';

class VoiceRecodeScreenWithScript extends StatefulWidget {
  const VoiceRecodeScreenWithScript({super.key});

  @override
  State<VoiceRecodeScreenWithScript> createState() => _VoiceRecodeScreenWithScriptState();
}

class _VoiceRecodeScreenWithScriptState extends State<VoiceRecodeScreenWithScript> with WidgetsBindingObserver {
  final VoiceRecodeCtr _controller = Get.find<VoiceRecodeCtr>();

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
      _controller.pausePracticeWithScript(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBarTitle: '음성 녹음',
        child: GetX<VoiceRecodeCtr>(
          builder: (_) => Stack(
            children: [
              if (_controller.practiceState.value == PracticeState.recoding ||
                  _controller.practiceState.value == PracticeState.beforeToStart ||
                  _controller.practiceState.value == PracticeState.pause ||
                  _controller.practiceState.value == PracticeState.end)
                Column(
                  children: [
                    Container(height: _controller.scriptListViewSize.value * 4 / 10),
                    const Divider(
                      height: 2,
                      color: Colors.red,
                    ),
                  ],
                ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 20,
                          color: Color(0xFFD13853),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          _controller.recodingStopWatch.value.elapsed.toString().substring(0, 10),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD13853),
                            height: 16 / 12,
                          ),
                        ),
                        Text(
                          ' / ${_controller.maxAudioTime.value?.text ?? ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: CustomScrollView(
                          key: _controller.scriptListViewKey,
                          controller: _controller.scriptScrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(height: _controller.scriptListViewSize.value * 5 / 10),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${index + 1} 문단",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          )),
                                      Stack(
                                        children: [
                                          Visibility(
                                            visible: _controller.promptSelectedOption.value == _controller.promptOptions[0],
                                            maintainState: true,
                                            maintainSize: true,
                                            maintainAnimation: true,
                                            child: Text(_controller.script?[index] ?? '',
                                                style: const TextStyle(
                                                  fontSize: 21,
                                                  height: 2.5,
                                                )),
                                          ),
                                          Visibility(
                                              visible: _controller.promptSelectedOption.value == _controller.promptOptions[1],
                                              child: GetX<VoiceRecodeCtr>(
                                                  builder: (_) => Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          if (_controller.keywords.value?.paragraphs?[index].keyWords == null)
                                                            const Text("키워드 불러오는 중..")
                                                          else
                                                            for (String keyword in _controller.keywords.value?.paragraphs?[index].keyWords ?? [])
                                                              Text(keyword,
                                                                  style: const TextStyle(
                                                                    fontSize: 21,
                                                                    height: 2.5,
                                                                  )),
                                                        ],
                                                      ))),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  );
                                },
                                childCount: (_controller.script?.length ?? 0),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: GetX<VoiceRecodeCtr>(
                                builder: (_) => Container(
                                  height: _controller.scriptListViewSize.value,
                                  alignment: Alignment.center,
                                  child: const Text(""),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  const Text('보이기:'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Switch(
                                  //     value: _controller.showKeyword.value,
                                  //     onChanged: (value) { _controller.toggleKeyword(); }
                                  // ),

                                  DropdownButton<String>(
                                    value: _controller.promptSelectedOption.value,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _controller.promptSelectedOption.value = newValue;
                                      });
                                    },
                                    items: _controller.promptOptions.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                      _controller.startPracticeWithScript(context);
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
                                        _controller.pausePracticeWithScript(context);
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
                                                          _controller.resetRecodingWithScript();
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
                                        _controller.resumePracticeWithScript(context);
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
                ),
              )
            ],
          ),
        ));
  }
}
