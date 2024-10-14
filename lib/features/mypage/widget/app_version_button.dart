import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:swm_peech_flutter/features/common/controllers/app_info_controller.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_device_info/platform_device_info.dart';

class AppVersionButton extends StatefulWidget {
  final hoverColor = Color(0xFFE9E9E9);
  final tapDownColor = Color(0xFFD9D9D9);
  final defaultColor = Color(0xFFF4F6FA);
  AppVersionButton({super.key});

  @override
  State<AppVersionButton> createState() => _AppVersionButtonState();
}

class _AppVersionButtonState extends State<AppVersionButton> {
  late Color _color;
  AppInfoController _appInfoController = Get.find<AppInfoController>();
  String appVersion = '';

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      print('packageInfo.version: ${packageInfo.version}');
      appVersion = packageInfo.version;
    });
  }

  @override
  void initState() {
    _color = widget.defaultColor;
    getAppVersion();
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
          _appInfoController.gotoStore(context);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(180, 10, 180, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _color,
          ),
          child: Text(
            "앱 버전 $appVersion (${PlatformDeviceInfo.type})",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF3B3E43),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
