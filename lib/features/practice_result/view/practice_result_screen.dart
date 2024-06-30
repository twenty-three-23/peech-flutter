import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          controller: controller.scrollController,
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: controller.practiceResult.value?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                if(index == 0)
                                  GestureDetector(
                                      onTap: () { controller.insertNewParagraph(0); },
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, color: Colors.grey,),
                                          Text(
                                            "문단 추가",
                                            style: TextStyle(
                                                color: Colors.grey
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Stack(
                                    children: [
                                      TextField(
                                        minLines: 1,
                                        maxLines: null,
                                        controller: controller.practiceResult.value?[index],
                                        decoration: const InputDecoration(
                                          hintText: "문단을 입력해주세요",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Positioned(
                                        right: 1,
                                        top: 1,
                                        child: GestureDetector(
                                          onTap: () { },
                                          child: const Icon(Icons.close,)
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () { controller.insertNewParagraph(index + 1); },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add, color: Colors.grey,),
                                        Text(
                                          "문단 추가",
                                          style: TextStyle(
                                            color: Colors.grey
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                if(index + 1 == controller.practiceResult.value?.length)
                                  const SizedBox(height: 20,),

                              ],
                            );
                          },
                        ),
                ),
                const Divider(height: 1,),
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
