import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final int minLines;
  final int? maxLines;
  final Function(String) onChanged;
  final String hintText;
  final bool showCounter;
  final TextEditingController? controller;

  const CommonTextField({
    super.key,
    this.minLines = 1,
    this.maxLines,
    this.onChanged = _defaultOnChanged,
    this.hintText = '',
    this.showCounter = false,
    this.controller
  });

  static void _defaultOnChanged(String value) {
    // 아무 동작도 하지 않는 기본 함수
  }

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onChanged: (value) => widget.onChanged(value),
      style: const TextStyle(
        fontSize: 16,
      ),
      buildCounter: (context,
          {required currentLength, required isFocused, maxLength}) {
        if(widget.showCounter) {
          return Text("$currentLength 자");
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(12.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              color: Colors.black,
              width: 1.2
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE5E8F0),
            width: 1
          ),
        ),
      ),
    );
  }
}
