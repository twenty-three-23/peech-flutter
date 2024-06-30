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
            builder: (_) => SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.practiceResult.value?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(controller.practiceResult.value?[index].content ?? "unknown");
                    },
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text("예상시간 다시 확인")),
                  ElevatedButton(onPressed: () {}, child: const Text("다시 연습하기")),
                  ElevatedButton(onPressed: () {}, child: const Text("홈으로 가기")),
                ],
              ),
            )
        ),
      ),
    );
  }
}
