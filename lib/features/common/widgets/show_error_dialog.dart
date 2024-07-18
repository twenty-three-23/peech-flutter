import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/utils/status_code_util.dart';

void showErrorDialog(GlobalKey<NavigatorState> navigatorKey, String message) {
  showDialog(
    context: navigatorKey.currentState!.context,
    builder: (BuildContext context) {
      int statusCode = StatusCodeUtil.getStatusCodeFromErrorMessage(message);
      String statusMessage = StatusCodeUtil.getMessage(statusCode);
      return AlertDialog(
        title: const Text('오류가 발견되었습니다.'),
        content: SingleChildScrollView(
            child: TextFormField(
                initialValue: statusMessage,
                minLines: 1,
                maxLines: null,
                readOnly: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                )
            )
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
