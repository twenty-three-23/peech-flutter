import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ColoredButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final RxBool isLoading;
  final RxString? subText;
  Color backgroundColor;
  Color textColor;
  Color subTextColor;

  ColoredButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.subText,
    RxBool? isLoading,
    this.backgroundColor = defaultBackgroundColor,
    this.textColor = defaultTextColor,
    this.subTextColor = defaultSubTextColor,
  }) : isLoading = isLoading ?? false.obs;

  static const defaultTextColor = Color(0xffffffff);
  static const defaultSubTextColor = Color(0xffffffff);
  static const defaultBackgroundColor = Color(0xFFFF5468);

  @override
  State<ColoredButton> createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ElevatedButton(
        onPressed: () => widget.onPressed(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(widget.backgroundColor),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 18,
                    ),
                  ),
                  if(widget.subText != null)
                    Obx(() => Text(
                        widget.subText?.value ?? '',
                        style: TextStyle(
                          color: widget.subTextColor,
                          fontSize: 10,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}