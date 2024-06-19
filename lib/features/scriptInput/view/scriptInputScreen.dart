import 'package:flutter/material.dart';

class ScriptInputScreen extends StatefulWidget {
  const ScriptInputScreen({super.key});

  @override
  State<ScriptInputScreen> createState() => _ScriptInputScreenState();
}

class _ScriptInputScreenState extends State<ScriptInputScreen> {
  @override
  Widget build(BuildContext context) {
    final scriptController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("대본으로 시작"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          const Text("대본을 입력해주세요"),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextField(
                maxLines: 20,
                controller: scriptController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

