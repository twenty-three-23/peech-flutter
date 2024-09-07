import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_feedbacks_data_souce.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/user_feedback_model.dart';

class ReviewController extends GetxController {
  Rx<String> reviewText = "".obs;

  void reviewRequired({
    required BuildContext context,
    Function()? endFunction,
  }) {
    reviewText.value = '';
    RemoteUserFeedbacksDataSource remoteUserFeedbacksDataSource = RemoteUserFeedbacksDataSource(AuthDioFactory().dio);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('저희 서비스는 어떠셨나요?'),
          content: TextField(
            minLines: 1,
            maxLines: null,
            decoration: const InputDecoration(hintText: '소중한 의견을 남겨주세요.'),
            onChanged: (value) {
              reviewText.value = value;
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('전송'),
              onPressed: () {
                Navigator.pop(context);
                UserFeedbackModel userFeedbackModel = UserFeedbackModel(message: reviewText.value);
                remoteUserFeedbacksDataSource.sendUserFeedback(userFeedbackModel.toJson()).then((value) {
                  Get.snackbar('피드백 전송', '소중한 피드백 감사합니다');
                });
                if (endFunction != null) endFunction();
              },
            ),
          ],
        );
      },
    );
  }
}
