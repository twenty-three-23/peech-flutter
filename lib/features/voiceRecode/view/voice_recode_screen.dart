import 'package:flutter/material.dart';

class VoiceRecodeScreen extends StatelessWidget {
  const VoiceRecodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("음성 녹음"),
      ),
      body: Center(child: Text("음성 녹음"),)
    );
  }
}
