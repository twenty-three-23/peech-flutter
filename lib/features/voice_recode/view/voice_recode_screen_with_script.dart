import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      _controller.stopPracticeWithScript();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
          title: const Text("음성 녹음"),
          actions: [
            GetX<VoiceRecodeCtr>(
              builder: (_) {
                if(_controller.practiceState.value == PracticeState.BEFORETOSTART) {
                  return ElevatedButton(
                      onPressed: () { _controller.startPracticeWithScript(); },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("녹음 시작"),
                          _controller.maxAudioTime.value == null
                              ? const SizedBox(width: 10, height: 10, child: CircularProgressIndicator(strokeWidth: 1,))
                              : Text(
                                  "(최대 ${_controller.maxAudioTime.value?.text ?? '?'})",
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                )
                        ],
                      )
                  );
                } else if(_controller.practiceState.value == PracticeState.RECODING) {
                  return Row(
                    children: [
                      Text(_controller.recodingStopWatch.value.elapsed.toString().substring(0, 10)),
                      const SizedBox(width: 10,),
                      ElevatedButton(onPressed: () { _controller.stopPracticeWithScript(); }, child: const Text("녹음 종료")),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Text(_controller.recodingStopWatch.value.elapsed.toString().substring(0, 10)),
                      const SizedBox(width: 10,),
                    ],
                  );
                }
              }
            ),
            const SizedBox(width: 8,),
          ],
        ),
        body: GetX<VoiceRecodeCtr>(
          builder: (_) => Stack(
            children: [
              if(_controller.practiceState.value == PracticeState.RECODING || _controller.practiceState.value == PracticeState.BEFORETOSTART)
                Column(
                  children: [
                    Container(height: _controller.scriptListViewSize.value * 4/10),
                    const Divider(height: 2, color: Colors.red,),
                  ],
                ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomScrollView(
                  key: _controller.scriptListViewKey,
                  controller: _controller.scriptScrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(height: _controller.scriptListViewSize.value * 5/10),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${index + 1} 문단",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      )
                                  ),
                                  Stack(
                                    children: [
                                      Visibility(
                                        visible: !_controller.showKeyword.value,
                                        maintainState: true,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        child: Text(
                                            _controller.script?[index] ?? '',
                                            style: const TextStyle(
                                              fontSize: 21,
                                              height: 2.5,
                                            )
                                        ),
                                      ),
                                      Visibility(
                                        visible: _controller.showKeyword.value,
                                        maintainState: true,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        child: GetX<VoiceRecodeCtr>(
                                          builder: (_) => Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              if(_controller.keywords.value?.paragraphs?[index].keyWords == null)
                                                const Text("키워드 불러오는 중..")
                                              else
                                                for(String keyword in _controller.keywords.value?.paragraphs?[index].keyWords ?? [])
                                                  Text(
                                                      keyword,
                                                      style: const TextStyle(
                                                        fontSize: 21,
                                                        height: 2.5,
                                                      )
                                                  ),
                                            ],
                                          )

                                        )
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40,),
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
                          child: _controller.practiceState.value == PracticeState.ENDRECODING
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () { _controller.endPractice(context); },
                                  child: const Text("분석 받기")
                              ),
                              IntrinsicWidth(
                                child: ElevatedButton(
                                    // onPressed: () { _controller.startPracticeWithScript(); },
                                    onPressed: () {
                                      _controller.resetRecoding();
                                    },
                                    child: const Text("다시 녹음하기")
                                ),
                              ),
                            ],
                          )
                              : const Text(""),
                        ),
                      ),
                    ),
                  ],
                )
              ),
              if(_controller.practiceState.value == PracticeState.RECODING || _controller.practiceState.value == PracticeState.BEFORETOSTART)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Divider(height: 1, color: Colors.grey,),
                          const Text('핵심 키워드만 보기'),
                          Switch(
                              value: _controller.showKeyword.value,
                              onChanged: (value) { _controller.toggleKeyword(); }
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
    );
  }
}