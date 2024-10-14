import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/custom_bottom_navigation.dart';
import 'package:swm_peech_flutter/features/home/controller/home_controller.dart';
import 'package:swm_peech_flutter/features/home/view/home_screen.dart';
import 'package:swm_peech_flutter/features/mypage/controller/mypage_controller.dart';
import 'package:swm_peech_flutter/features/mypage/view/mypage_screen.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/view/history_screen.dart';

import '../../home/view/home_screen2.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  final homeController = Get.find<HomeCtr>();
  final historyController = Get.find<HistoryCtr>();
  final myPageController = Get.find<MyPageController>();

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
          HistoryScreen(),
          MyPageScreen(),
        ],
      ),
    );
  }
}
