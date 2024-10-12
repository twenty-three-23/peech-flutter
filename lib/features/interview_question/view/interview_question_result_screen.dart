import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';

import '../controller/interview_question_input_controller.dart';

class InterviewQuestionResultScreen extends StatelessWidget {
  const InterviewQuestionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InterviewQuestionInputController controller = Get.find<InterviewQuestionInputController>();

    List<Widget> widgetList = [];

    return CommonScaffold(
      appBarTitle: '',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        children: [
          Text(
            "분석한 예상 질문이에요",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff3B3E43),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "자기소개 내용을 분석하여 예상 질문을 뽑아봤어요",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xff3B3E43),
            ),
          ),
          SizedBox(height: 24),
          Obx(() {
            // interviewQuestions가 null이거나 비어있는 경우 처리
            final List<String>? interviewQuestions = controller.interviewQuestions.value.interviewQuestions;

            if (interviewQuestions == null || interviewQuestions.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              // for 문으로 위젯 리스트 생성
              children: interviewQuestions.map((interviewQuestion) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffC6C9D3)),
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xffFBFCFD),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        interviewQuestion,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3B3E43),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}
