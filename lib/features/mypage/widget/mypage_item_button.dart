import 'package:flutter/material.dart';

class MypageItemButton extends StatefulWidget {
  final Function() onTap;
  final String text;
  final hoverColor = ThemeData().hoverColor;
  final tapDownColor = ThemeData().focusColor;
  final defaultColor = Color(0xFFFFFFFF);
  MypageItemButton({super.key, required this.text, required this.onTap});

  @override
  State<MypageItemButton> createState() => _MypageItemButtonState();
}

class _MypageItemButtonState extends State<MypageItemButton> {
  late Color _color;

  @override
  void initState() {
    _color = widget.defaultColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _color = widget.hoverColor;
        });
      },
      onExit: (_) {
        setState(() {
          _color = widget.defaultColor;
        });
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _color = widget.tapDownColor;
          });
        },
        onTapUp: (_) {
          setState(() {
            _color = widget.defaultColor;
          });
        },
        onTapCancel: () {
          setState(() {
            _color = widget.defaultColor;
          });
        },
        onTap: () {
          widget.onTap();
        },
        child: Container(
          height: 48,
          color: _color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3B3E43),
                  fontWeight: FontWeight.w400,
                  height: 24 / 16,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
