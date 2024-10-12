import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';
import 'package:swm_peech_flutter/features/interview_question/controller/interview_question_input_controller.dart';
import 'package:swm_peech_flutter/features/practice_result/controller/practice_result_controller.dart';
import 'package:swm_peech_flutter/features/practice_result/widget/editing_dialog.dart';

class PracticeResultScreen extends StatefulWidget {
  const PracticeResultScreen({super.key});

  @override
  State<PracticeResultScreen> createState() => _PracticeResultScreenState();
}

class _PracticeResultScreenState extends State<PracticeResultScreen> {
  PracticeResultCtr controller = Get.find<PracticeResultCtr>();
  InterviewQuestionInputController interviewQuestionInputController = Get.put(InterviewQuestionInputController());
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPracticeResult(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBarColor: const Color(0xffF4F6FA),
      appBarTitle: '연습 결과',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: GetX<PracticeResultCtr>(
            builder: (_) => Column(
                  children: [
                    if (controller.isLoading.value == false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          const Text("분석 결과에요", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 34 / 22)),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                  '총 ${controller.practiceResult.value?.totalTime == null ? controller.practiceResult.value?.totalRealTime ?? "??:??:??" : controller.practiceResult.value?.totalTime ?? "??:??:??"}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 26 / 18)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: controller.isLoading.value == true
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 30,
                                ),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white, // 배경 색상
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                                      child: Text(
                                                        controller.practiceResult.value?.script?[index].time ?? "??:??:??",
                                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff3B3E43)),
                                                      ),
                                                    ),
                                                    // TODO 빠른 데모 출시를 위해 임시로 숨김.
                                                    // const SizedBox(width: 2,),
                                                    // if(controller.practiceResult.value?.script?[index].nowStatus == NowStatus.realTime)
                                                    //   const Text(
                                                    //     "측정",
                                                    //     style: TextStyle(
                                                    //       fontSize: 9,
                                                    //       color: Colors.grey,
                                                    //       fontWeight: FontWeight.bold
                                                    //     ),
                                                    //   )
                                                    // else if(controller.practiceResult.value?.script?[index].nowStatus == NowStatus.expectedTime)
                                                    //   const Text(
                                                    //     "예상",
                                                    //     style: TextStyle(
                                                    //         fontSize: 9,
                                                    //         color: Colors.grey,
                                                    //         fontWeight: FontWeight.bold
                                                    //     ),
                                                    //   )
                                                    // else if(controller.practiceResult.value?.script?[index].nowStatus == NowStatus.realAndExpectedTime)
                                                    //     const Text(
                                                    //       "측정+예상",
                                                    //       style: TextStyle(
                                                    //           fontSize: 9,
                                                    //           color: Colors.grey,
                                                    //           fontWeight: FontWeight.bold
                                                    //       ),
                                                    //     )
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    if (controller.practiceResult.value?.script?[index].measurementResult == '적정')
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xff63BF1C),
                                                          borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                          child: Text(
                                                            controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                                          ),
                                                        ),
                                                      )
                                                    else if (controller.practiceResult.value?.script?[index].measurementResult == '빠름')
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(0xffFB3149),
                                                            borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                          child: Text(
                                                            controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                                          ),
                                                        ),
                                                      )
                                                    else if (controller.practiceResult.value?.script?[index].measurementResult == '느림')
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(0xff2A79FF),
                                                            borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                          child: Text(
                                                            controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                                          ),
                                                        ),
                                                      )
                                                    else
                                                      Text(
                                                        controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                                      ),
                                                  ],
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
                                                      text: TextSpan(style: const TextStyle(color: Colors.black, fontSize: 16, height: 1.4), children: [
                                                        for (int j = 0; j < (controller.practiceResult.value?.script?[index].sentences?.length ?? 0); j++)
                                                          (controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent == null ||
                                                                  controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent == "")
                                                              ? TextSpan(
                                                                  text: "빈 문장 ",
                                                                  style: const TextStyle(color: Colors.grey),
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = () {
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (context) {
                                                                            return editingDialog(
                                                                                initialText:
                                                                                    controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent ?? "",
                                                                                onSave: (textEditingController) =>
                                                                                    controller.editingDialogSaveBtn(textEditingController, context, index, j),
                                                                                onCancel: () => controller.editingDialogCancelBtn(context));
                                                                          });
                                                                    })
                                                              : TextSpan(
                                                                  text: "${controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent} ",
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = () {
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (context) {
                                                                            return editingDialog(
                                                                                initialText:
                                                                                    controller.practiceResult.value?.script?[index].sentences?[j].sentenceContent ?? "",
                                                                                onSave: (textEditingController) =>
                                                                                    controller.editingDialogSaveBtn(textEditingController, context, index, j),
                                                                                onCancel: () => controller.editingDialogCancelBtn(context));
                                                                          });
                                                                    })
                                                      ]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16,)
                                  ],
                                );
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (controller.isLoading.value == false)
                          Expanded(
                            child: ColoredButton(
                              text: '예상 면접 질문 받아보기',
                              onPressed: () {
                                interviewQuestionInputController.getInterviewQuestionsBySTTResult(controller.getScriptContent());
                                Navigator.pushNamed(context, "/interviewQuestionsResult");
                              },
                              backgroundColor: const Color(0xFF3B3E43),
                              textColor: const Color(0xFFFFFFFF),
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: ColoredButton(
                            backgroundColor: const Color(0xFF3B3E43),
                            textColor: const Color(0xFFFFFFFF),
                            text: '나가기',
                            onPressed: () {
                              if (controller.isEdited) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("나가기",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              height: 26 / 18,
                                            )),
                                        content: const Text(
                                          "반영되지 않은 수정 사항이 있다면\n저장하기를 눌러주세요\n'기록보기'에서 확인할 수 있습니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 24 / 16,
                                          ),
                                        ),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ColoredButton(
                                                  text: '닫기',
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  backgroundColor: const Color(0xFFF4F6FA),
                                                  textColor: const Color(0xFF3B3E43),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: ColoredButton(
                                                  text: '나가기',
                                                  onPressed: () {
                                                    controller.homeBtn(context);
                                                  },
                                                  backgroundColor: const Color(0xFF3B3E43),
                                                  textColor: const Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                controller.homeBtn(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )),
      ),
    );
  }
}
