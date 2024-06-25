import 'package:flutter/material.dart';

class ThemeInputScreen extends StatelessWidget {
  const ThemeInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("발표 주제 입력"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("발표 주제를 입력해주세요"),
            SizedBox(height: 8,),
            TextField(),
          ],
        ),
      ),
    );
  }
}
