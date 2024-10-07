import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_text_field.dart';
import 'package:swm_peech_flutter/features/interview_question/controller/interview_question_input_controller.dart';

class InterviewQuestionInputScreen extends StatelessWidget {
  const InterviewQuestionInputScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<InterviewQuestionInputController>();

    return CommonScaffold(
        appBarTitle: "예상 면접 질문",
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "자기소개를 적어보세요",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3B3E43),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "자기소개 내용을 적으면 예상 질문을 확인 할 수 있어요",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff3B3E43),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                height: 212,
                child: CommonTextField(
                  hintText: "자기소개를 적어주세요",
                  minLines: 10,
                  showCounter: true,
                  controller: controller.textFieldController,
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff3B3E43),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                    onPressed: () {
                      controller.getInterviewQuestions();
                      Navigator.pushNamed(context, "/interviewQuestionsResult");
                    },
                    child: Text(
                      "입력 완료",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ),
              SizedBox(height: 8),
            ],

          ),
        ));
  }
}