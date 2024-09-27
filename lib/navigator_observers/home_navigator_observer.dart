import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';

class HomeNavigatorObserver extends NavigatorObserver {
  final UserInfoController userInfoController = Get.find<UserInfoController>();

  // 홈 화으로 이동할 때
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/home') {
      print('[HomeNavigatorObserver] didPush: ${route.settings.name}');
      userInfoController.getUserAudioTimeInfo();
    }
  }

  // 다른 화면에서 홈 화면으로 돌아올 때
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name == '/home') {
      print('[HomeNavigatorObserver] didPop: ${previousRoute?.settings.name}');
      userInfoController.getUserAudioTimeInfo();
    }
  }
}
