import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/widgets/limited_text.dart';

Widget historyPathUnit({
  required String text,
  required Function onClick
}){
  return Row(
    children: [
      const Icon(Icons.arrow_right_rounded),
      GestureDetector(
        child: limitedText(text: text, limit: 15),
        onTap: () { onClick(); },
      ),
    ],
  );
}