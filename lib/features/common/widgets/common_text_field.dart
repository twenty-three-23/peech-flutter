import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final int maxLines;
  final Function(String) onChanged;
  final String hintText;

  const CommonTextField({super.key, this.maxLines = 1, this.onChanged = _defaultOnChanged, this.hintText = ''});

  static void _defaultOnChanged(String value) {
    // 아무 동작도 하지 않는 기본 함수
  }

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 312,
      child: TextField(
        maxLines: 1,
        onChanged: (value) => widget.onChanged(value),
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
      ),
    );
  }
}
