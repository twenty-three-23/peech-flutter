import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/script_input/controller/script_input_controller.dart';

class ScriptExpectedTimeScreen extends StatefulWidget {
  const ScriptExpectedTimeScreen({super.key});

  @override
  State<ScriptExpectedTimeScreen> createState() => _ScriptExpectedTimeScreenState();
}

class _ScriptExpectedTimeScreenState extends State<ScriptExpectedTimeScreen> {

  final controller = Get.find<ScriptInputCtr>();

  @override
  void initState() {
    controller.scriptExpectedTimeScriptInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("대본 예상 시간"),
      ),
      body: GetX<ScriptInputCtr>(
        builder: (_) {
          if(controller.expectedTimeIsLoading.value == true) {
            return const Center(
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
                    Text("전체 예상시간: ${controller.scriptExpectedTime.value?.expectedTimeByScript ?? "예상 시간 결과 존재하지 않음"}"),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.expectedTimeScript.value?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text("${index + 1}번째 문단 - ${controller.scriptExpectedTime.value?.expectedTimeByParagraphs[index].expectedTimePerParagraph ?? "예상 시간 결과 존재하지 않음"}"),
                            Text(controller.expectedTimeScript.value?[index] ?? "문단 결과 존재하지 않음"),
                          ],
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () { controller.gotoPracticeBtn(context); },
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
