import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/script_input/controller/script_input_controller.dart';

class ScriptExpectedTimeScreen extends StatelessWidget {
  const ScriptExpectedTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ScriptInputCtr>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("대본 예상 시간"),
      ),
      body: GetX<ScriptInputCtr>(
        builder: (_) {
          if(controller.isLoading.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(controller.scriptExpectedTime.value != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("전체 예상시간: ${controller.scriptExpectedTime.value?.expectedAllTime ?? "전체 예상시간 결과 존재하지 않음"}"),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.scriptExpectedTime.value?.paragraphs?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text("${index + 1}번째 문단 - ${controller.scriptExpectedTime.value?.expectedTimePerParagraphs?[index]?.time ?? "예상 시간 결과 존재하지 않음"}"),
                            Text(controller.scriptExpectedTime.value?.paragraphs?[index]?.paragraph ?? "문단 결과 존재하지 않음"),
                          ],
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () { controller.gotoPractice(context); },
                          child: const Text("연습하러 가기")
                      ),
                    ),
                      
                  ],
                ),
              ),
            );
          }
          else {
            return const Text('');
          }
        },
      ),
    );
  }
}
