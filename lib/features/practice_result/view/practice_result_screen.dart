import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_result/controller/practice_result_controller.dart';
import 'package:swm_peech_flutter/features/practice_result/model/now_status.dart';
import 'package:swm_peech_flutter/features/practice_result/widget/editing_dialog.dart';

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
                  child: controller.isLoading.value == true
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
                          itemCount: controller.practiceResult.value?.script?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${controller.practiceResult.value?.script?[index].time ?? "??:??:??"}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(width: 2,),
                                        if(controller.practiceResult.value?.script?[index].nowStatus == NowStatus.realTime)
                                          const Text(
                                            "측정",
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                        else if(controller.practiceResult.value?.script?[index].nowStatus == NowStatus.expectedTime)
                                          const Text(
                                            "예상",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                        else if(controller.practiceResult.value?.script?[index].nowStatus == NowStatus.realAndExpectedTime)
                                            const Text(
                                              "측정+예상",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () { controller.insertNewParagraph(index); },
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
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                height: 1.4
                                              ),
                                              children: [
                                                for(int j = 0; j < (controller.practiceResult.value?.script?[index].sentences?.length ?? 0); j++)
                                                  TextSpan(
                                                    text: "${controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent} ",
                                                    recognizer: TapGestureRecognizer()..onTap = () {
                                                      showDialog(context: context, builder: (context) {
                                                        return editingDialog(
                                                          initialText: controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent ?? "",
                                                          onSave: (textEditingController) => controller.editingDialogSaveBtn(textEditingController, context, index, j),
                                                          onCancel: () => controller.editingDialogCancelBtn(context)
                                                        );
                                                      });
                                                    }
                                                  )
                                              ]
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 1,
                                        top: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.removeParagraph(index);
                                          },
                                          child: const Icon(Icons.close,size: 18,)
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                if(index + 1 == controller.practiceResult.value?.script?.length)
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


                              ],
                            );
                          },
                        ),
                ),
                const Divider(height: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if(controller.isLoading.value == false)
                      ElevatedButton(
                          onPressed: () { controller.editingFinishBtn();  },
                          child: const Text("예상시간 재확인")
                      ),
                    if(controller.isLoading.value == false)
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text("연습하기")
                      ),
                    ElevatedButton(
                      onPressed: () { controller.homeButton(context); },
                      child: const Text("홈")
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
