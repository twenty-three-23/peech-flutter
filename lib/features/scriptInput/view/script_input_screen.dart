import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                  builder: (_) => ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.script.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.script.value[index],
                                  minLines: 1,
                                  maxLines: null,
                                  onChanged: (value) {
                                    controller.updateScript(index, value);
                                  },
                                  decoration: InputDecoration(
                                      hintText: "문단을 입력해주세요",
                                      border: const OutlineInputBorder(),
                                      counterText: "${controller.script.value[index].text.length} 자"
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${index + 1}문단",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  IconButton(
                                    onPressed: () { controller.removeParagraph(index); },
                                    icon: const Icon(Icons.close)
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 15,),
                        ],
                      );
                    },
                  ),
                )
              ),
            ),
            TextButton(
              onPressed: () { controller.addParagraph(); },
              child: const Text("문단 추가")
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    child: const Text("대본 입력 완료"),
                    onPressed: () {
                      controller.getExpectedTime();
                    },
                ),
              ),
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

