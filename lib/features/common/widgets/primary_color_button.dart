import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class PrimaryColorButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final RxBool isLoading;
  PrimaryColorButton({super.key, required this.text, required this.onPressed, RxBool? isLoading}) : isLoading = isLoading ?? false.obs;

  @override
  State<PrimaryColorButton> createState() => _PrimaryColorButtonState();
}

class _PrimaryColorButtonState extends State<PrimaryColorButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: widget.isLoading.value,
              child: const SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !widget.isLoading.value,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}