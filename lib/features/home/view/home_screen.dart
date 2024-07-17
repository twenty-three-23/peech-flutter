import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<HomeCtr>();

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Peech - 당신의 발표 도우미",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 50,),
            GetX<HomeCtr>(
              builder: (_) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("총"),
                      const SizedBox(width: 3,),
                      controller.remainingTime.value == null
                          ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2,))
                          : Text(
                              controller.remainingTime.value?.text ?? "?",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                      const SizedBox(width: 3,),
                      const Text("사용 가능"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("1회 최대"),
                      const SizedBox(width: 3,),
                      controller.maxAudioTime.value == null
                          ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2,))
                          : Text(
                              controller.maxAudioTime.value?.text ?? "?",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                      const SizedBox(width: 3,),
                      const Text("연습 가능"),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.getUserAudioTimeInfo();
                    },
                    child: const Icon(Icons.refresh, size: 17,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
                onPressed: () {
                    LocalPracticeModeStorage().setMode(PracticeMode.withScript);
                    Navigator.pushNamed(context, '/themeInput');
                  },
                child: const Text("대본 입력하고 시작하기")
            ),
            TextButton(
                onPressed: () {
                    LocalPracticeModeStorage().setMode(PracticeMode.noScript);
                    Navigator.pushNamed(context, '/themeInput');
                  },
                child: const Text("대본 입력하지 않고 시작하기")
            ),
            TextButton(
                onPressed: () { Navigator.pushNamed(context, '/historyThemeList'); },
                child: const Text("기록 보기")
            ),
          ],
        ),
      ),
    );
  }
}
