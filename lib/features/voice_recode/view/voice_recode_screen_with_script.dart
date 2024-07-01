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
      _controller.stopRecording();
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
                  return ElevatedButton(onPressed: () { _controller.startPracticeWithScript(); }, child: const Text("녹음 시작"));
                } else if(_controller.practiceState.value == PracticeState.RECODING) {
                  return const Text("녹음 중");
                } else {
                  return const Text("");
                }
              }
            ),
            const SizedBox(width: 8,),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            key: _controller.scriptListViewKey,
            controller: _controller.scriptScrollController,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: _controller.script?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text(_controller.script?[index] ?? ''),
                  if(index + 1 == _controller.script?.length)
                    GetX<VoiceRecodeCtr>(
                      builder: (_) => Container(
                        height: _controller.scriptListViewSize.value,
                        alignment: Alignment.center,
                        child: _controller.practiceState.value == PracticeState.ENDRECODING
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: () { _controller.endPractice(context); }, child: const Text("분석 받기")),
                              ElevatedButton(onPressed: () { _controller.startPracticeWithScript(); }, child: const Text("다시 녹음하기")),
                            ],
                          )
                          : const Text(""),
                      ),
                    ),
                ],
              );
            }
          ),
        ),
    );
  }
}
