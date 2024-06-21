import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/voiceRecode/controller/voice_recode_controller.dart';

class VoiceRecodeScreenWithScript extends StatefulWidget {
  const VoiceRecodeScreenWithScript({super.key});

  @override
  State<VoiceRecodeScreenWithScript> createState() => _VoiceRecodeScreenWithScriptState();
}

class _VoiceRecodeScreenWithScriptState extends State<VoiceRecodeScreenWithScript> with WidgetsBindingObserver {

  final VoiceRecodeCtr _controller = Get.put(VoiceRecodeCtr());

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
    if (state == AppLifecycleState.paused) {
      // 앱 백그라운드로 전환
      _controller.onClose();
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
        onPopInvoked: (_) async {
          _controller.onClose();
          return Future.value(true);
        },
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
                  child: Text(_controller.isRecording.value ? '녹음 마치기' : '녹음 시작'),
                ),
                ElevatedButton(
                  onPressed: () {  },
                  child: const Text("녹음본 분석받기"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
