import 'package:flutter/material.dart';

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
                onPressed: () { Navigator.pushNamed(context, '/themeInput'); },
                child: const Text("대본 입력하고 시작하기")
            ),
            TextButton(onPressed: () { Navigator.pushNamed(context, '/themeInput'); }, child: const Text("대본 입력하지 않고 시작하기")),
            TextButton(onPressed: () {}, child: const Text("기록 보기")),
          ],
        ),
      ),
    );
  }
}
