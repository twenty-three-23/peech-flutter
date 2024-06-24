import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/scriptInput/view/script_input_screen.dart';

import '../../voiceRecode/view/voice_recode_screen_no_script.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Peech - 당신의 발표 도우미"),
            const SizedBox(height: 20,),
            TextButton(
                onPressed: () { Navigator.pushNamed(context, '/scriptInput'); },
                child: const Text("대본 입력하고 시작하기")
            ),
            TextButton(onPressed: () { Navigator.pushNamed(context, '/voiceRecodeNoScript'); }, child: const Text("대본 입력하지 않고 시작하기")),
            TextButton(onPressed: () {}, child: const Text("기록 보기")),
          ],
        ),
      ),
    );
  }
}
