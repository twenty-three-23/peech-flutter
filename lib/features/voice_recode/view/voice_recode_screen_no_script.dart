import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/voice_recode/controller/voice_recode_controller.dart';
import 'package:swm_peech_flutter/features/voice_recode/model/practice_state.dart';

class VoiceRecodeScreenNoScript extends StatefulWidget {
  const VoiceRecodeScreenNoScript({super.key});

  @override
  State<VoiceRecodeScreenNoScript> createState() => _VoiceRecodeScreenNoScriptState();
}

class _VoiceRecodeScreenNoScriptState extends State<VoiceRecodeScreenNoScript> with WidgetsBindingObserver {

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
      ),
      body: GetX<VoiceRecodeCtr>(
        builder: (_) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  color: _controller.isRecording.value ? Colors.black : Colors.grey,
                  size: 150,
                  Icons.keyboard_voice_rounded),
              const SizedBox(height: 30,),
              if(_controller.practiceState.value == PracticeState.BEFORETOSTART)
                ElevatedButton(onPressed: () { _controller.startPracticeNoScript(); }, child: const Text("녹음 시작"))
              else if(_controller.practiceState.value == PracticeState.RECODING)
                Column(
                  children: [
                    Text(_controller.recodingStopWatch.value.elapsed.toString().substring(0, 10)),
                    ElevatedButton(onPressed: () { _controller.stopRecording(); }, child: const Text("녹음 종료")),
                  ],
                )
              else if(_controller.practiceState.value == PracticeState.ENDRECODING)
                Column(
                  children: [
                    Text(_controller.recodingStopWatch.value.elapsed.toString().substring(0, 10)),
                    ElevatedButton(onPressed: () { _controller.startPracticeNoScript(); }, child: const Text("다시 녹음하기")),
                    ElevatedButton(onPressed: () { _controller.endPractice(context); }, child: const Text("분석 받기")),
                  ],
                )
              else const Text("error: 진행할 수 없습니다")
            ],
          ),
        ),
      ),
    );
  }
}
