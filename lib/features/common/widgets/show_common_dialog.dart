import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/widgets/primary_color_button.dart';

void showCommonDialog({
  required BuildContext context,
  required String title,
  required String message,
  bool showFirstButton = true,
  bool showSecondButton = true,
  String firstButtonText = '닫기',
  String secondButtonText = '확인',
  Function()? firstAction,
  Function()? secondAction,
  isFirstButtonToClose = false,
  isSecondButtonToClose = false,
  bool barrierDismissible = true,
}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: barrierDismissible,
          child: AlertDialog(
            title: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 26 / 18,
                )),
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 24 / 16,
              ),
            ),
            actions: [
              Row(
                children: [
                  if (showFirstButton)
                    Expanded(
                      child: ColoredButton(
                        text: firstButtonText,
                        onPressed: () {
                          if (isFirstButtonToClose) {
                            Navigator.of(context).pop();
                          }
                          if (firstAction != null) {
                            firstAction();
                          }
                        },
                        backgroundColor: const Color(0xFFF4F6FA),
                        textColor: const Color(0xFF3B3E43),
                      ),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  if (showSecondButton)
                    Expanded(
                      child: ColoredButton(
                        text: secondButtonText,
                        onPressed: () {
                          if (isSecondButtonToClose) {
                            Navigator.of(context).pop();
                          }
                          if (secondAction != null) {
                            secondAction();
                          }
                        },
                        backgroundColor: const Color(0xFF3B3E43),
                        textColor: const Color(0xFFFFFFFF),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      });
}
