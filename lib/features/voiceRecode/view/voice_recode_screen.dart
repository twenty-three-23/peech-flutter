import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/voiceRecode/controller/voice_recode_controller.dart';


class VoiceRecodeScreen extends StatelessWidget {
  const VoiceRecodeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final VoiceRecodeCtr _controller = Get.put(VoiceRecodeCtr());

    return Scaffold(
      appBar: AppBar(
        title: const Text('음성 녹음'),
      ),
      body: GetX<VoiceRecodeCtr>(
        builder: (_) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _controller.isRecording.value ? _controller.stopRecording : _controller.startRecording,
                child: Text(_controller.isRecording.value ? 'Stop Recording' : 'Start Recording'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _controller.isPlaying.value ? _controller.stopPlaying : _controller.startPlaying,
                child: Text(_controller.isPlaying.value ? 'Stop Playing' : 'Start Playing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
