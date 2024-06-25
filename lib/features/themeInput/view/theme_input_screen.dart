import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/dataSource/local_practice_mode_storage.dart';

class ThemeInputScreen extends StatelessWidget {
  const ThemeInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("발표 주제 입력"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("발표 주제를 입력해주세요"),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              minLines: 1,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "6월 25일 발표 연습",
                  border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
              onPressed: () {
                if (LocalPracticeModeStorage().getMode() == PracticeMode.withScript) {
                  Navigator.pushNamed(context, '/scriptInput');
                }
                else if (LocalPracticeModeStorage().getMode() == PracticeMode.noScript) {
                  Navigator.pushNamed(context, '/voiceRecodeNoScript');
                }
              },
              child: const Text("입력 완료")
          ),
          const SizedBox(height: 100,),
        ],
      ),
    );
  }
}
