import 'package:flutter/material.dart';

Widget editingDialog({
  required String initialText,
  required Function(TextEditingController) onSave,
  required Function() onCancel,
}) {
  TextEditingController textEditingController = TextEditingController(text: initialText);
  return AlertDialog(
    title: const Text("문장 수정하기"),
    content: TextField(
      autofocus: true,
      minLines: 1,
      maxLines: null,
      controller: textEditingController,
      decoration: const InputDecoration(
          hintText: "문장을 입력해주세요",
          border: InputBorder.none
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => onCancel(),
        child: const Text("취소"),
      ),
      TextButton(
        onPressed: () => onSave(textEditingController),
        child: const Text("확인"),
      ),
    ],
  );
}