import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_device_info/platform_device_info.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/custom_bottom_navigation.dart';
import 'package:swm_peech_flutter/features/home/controller/home_controller.dart';
import 'package:swm_peech_flutter/features/mypage/controller/mypage_controller.dart';
import 'package:swm_peech_flutter/features/mypage/view/mypage_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_view.dart';
import 'package:swm_peech_flutter/features/root/controller/root_controller.dart';

import '../../home/view/home_screen2.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  final rootController = Get.find<RootCtr>();
  final homeController = Get.find<HomeCtr>();
  final historyController = Get.find<HistoryCtr>();
  final myPageController = Get.find<MyPageController>();

  @override
  void initState() {
    if (PlatformDeviceInfo.isIOS() && !kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        rootController.trackingTransparencyRequest();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideAppBar: true,
      bottomNavigationBar: CustomBottomNavigation(
        initialIndex: 0,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            homeController.enter();
          } else if (index == 1) {
            historyController.enter();
          } else if (index == 2) {
            myPageController.enter();
          }
        },
      ),
      child: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen2(),
          HistoryView(),
          MyPageScreen(),
        ],
      ),
    );
  }
}
