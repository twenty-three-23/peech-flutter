import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_result/controller/practice_result_controller.dart';

class PracticeResultScreen extends StatelessWidget {
  const PracticeResultScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<PracticeResultCtr>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("연습 결과"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetX<PracticeResultCtr>(
            builder: (_) => Column(
              children: [
                Expanded(
                  child: controller.practiceResult.value == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 30,),
                            Text("음성 파일을 분석중이에요")
                          ],
                        )
                      : ListView.builder(
                          itemCount: controller.practiceResult.value?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: TextField(
                                minLines: 1,
                                maxLines: null,
                                controller: controller.practiceResult.value?[index],
                              ),
                            );
                          },
                        ),
                ),
                const Divider(height: 1,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("예상시간 재확인")),
                    ElevatedButton(onPressed: () {}, child: const Text("연습하기")),
                    ElevatedButton(onPressed: () {}, child: const Text("홈")),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
