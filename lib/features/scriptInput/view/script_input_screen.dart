import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/script_input_controller.dart';

class ScriptInputScreen extends StatefulWidget {
  const ScriptInputScreen({super.key});

  @override
  State<ScriptInputScreen> createState() => _ScriptInputScreenState();
}

class _ScriptInputScreenState extends State<ScriptInputScreen> {

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ScriptInputCtr>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("대본으로 시작"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text("대본을 입력해주세요"),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GetX<ScriptInputCtr>(
                  builder: (_) => TextField(
                    controller: controller.textEditingController,
                    minLines: 1,
                    maxLines: null,
                    onChanged: (value) {
                      controller.updateScript(value);
                    },
                    decoration: InputDecoration(
                        hintText: "안녕하세요. 발표 시작하겠습니다...",
                        border: const OutlineInputBorder(),
                        counterText: "${controller.script.value?.length ?? 0} 자"
                    ),
                  ),
                )
              ),
            ),
            TextButton(
                child: const Text("대본 입력 완료"),
                onPressed: () {
                  controller.getExpectedTime();
                },
            ),
            GetX<ScriptInputCtr>(
              builder: (_) {
                if(controller.isLoading.value == true) {
                  return const CircularProgressIndicator();
                }
                else if(controller.scriptExpectedTime.value != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  );
                }
                else {
                  return const Text('');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

