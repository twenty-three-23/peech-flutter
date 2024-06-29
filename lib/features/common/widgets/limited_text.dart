import 'package:flutter/material.dart';

Widget limitedText({
  required String text,
  required int limit,
  TextStyle? textStyle
}) {
  if(text.length > limit) {
    return Text(
      "${text.substring(0, limit)}...",
      style: textStyle,
    );
  }
  else {
    return Text(
      text,
      style: textStyle,
    );
  }
}