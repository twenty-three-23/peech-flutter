import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/voice_recode/controller/voice_recode_controller.dart';

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
            builder: (_) => ElevatedButton(
              onPressed: _controller.isRecording.value ? _controller.stopRecording : _controller.startRecording,
              child: Text(_controller.isRecording.value ? '녹음 완료 및 분석받기' : '녹음 시작'),
            ),
          ),
          const SizedBox(width: 8,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _controller.script?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_controller.script?[index] ?? ''),
                const SizedBox(height: 10,),
              ],
            );
          }
        ),
      ),
    );
  }
}
