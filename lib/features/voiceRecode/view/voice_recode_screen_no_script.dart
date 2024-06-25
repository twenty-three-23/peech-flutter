import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/voiceRecode/controller/voice_recode_controller.dart';

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
      body: PopScope(
        child: GetX<VoiceRecodeCtr>(
          builder: (_) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                    color: _controller.isRecording.value ? Colors.black : Colors.grey,
                    size: 150,
                    Icons.keyboard_voice_rounded),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: _controller.isRecording.value ? _controller.stopRecording : _controller.startRecording,
                  child: Text(_controller.isRecording.value ? '녹음 완료 및 분석받기' : '녹음 시작'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
