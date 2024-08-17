import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_text_field.dart';
import 'package:swm_peech_flutter/features/common/widgets/primary_color_button.dart';
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/progress_indicator_filled.svg',
                          semanticsLabel: 'progress bar'
                      ),
                      const SizedBox(width: 4,),
                      SvgPicture.asset(
                          'assets/images/progress_indicator_filled.svg',
                          semanticsLabel: 'progress bar'
                      ),
                      const SizedBox(width: 4,),
                      SvgPicture.asset(
                          'assets/images/progress_indicator_filled.svg',
                          semanticsLabel: 'progress bar'
                      ),
                      const SizedBox(width: 4,),
                      SvgPicture.asset(
                          'assets/images/progress_indicator_empty.svg',
                          semanticsLabel: 'progress bar'
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          const Text(
                              "대본에 대한 예상 시간이에요.",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3B3E43),
                                height: 34 / 22
                              )
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              const SizedBox(width: 4,),
                              Text(
                                  '총 ${controller.scriptExpectedTime.value?.expectedTimeByScript ?? "불러올 수 없음"}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3B3E43),
                                    height: 26 / 18
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: 24,),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.expectedTimeScript.value?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Text(
                                    controller.scriptExpectedTime.value?.expectedTimeByParagraphs[index].expectedTimePerParagraph ?? "예상 시간 결과 불러올 수 없음",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3B3E43),
                                      height: 18 / 14
                                    )
                                  ),
                                  const SizedBox(height: 4,),
                                  CommonTextField(
                                    readOnly: true,
                                    initialText: controller.expectedTimeScript.value?[index] ?? "문단 결과 존재하지 않음",
                                    showCounter: true,
                                  ),
                                  const SizedBox(height: 8,),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryColorButton(
                          text: '연습하러 가기',
                          onPressed: () { controller.gotoPracticeBtn(context); }
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8,)
              ],
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
