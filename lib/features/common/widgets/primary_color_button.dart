import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryColorButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  PrimaryColorButton({super.key, required this.text, required this.onPressed});

  @override
  State<PrimaryColorButton> createState() => _PrimaryColorButtonState();
}

class _PrimaryColorButtonState extends State<PrimaryColorButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressed(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFFF5468)),
        fixedSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 50)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          color: Color(0xffffffff),
          fontSize: 18,
        ),
      ),
    );;
  }
}