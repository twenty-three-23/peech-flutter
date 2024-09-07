import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/app_info_controller.dart';
import 'package:swm_peech_flutter/features/common/controllers/review_controller.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';

class GlobalControllersInitializer {
  Future<void> initialize() async {
    Get.put(UserInfoController()); //유저 정보 전역 컨트롤러
    Get.put(AppInfoController()); // 앱 정보 전역 컨트롤러
    Get.put(ReviewController()); // 리뷰 전역 컨트롤러
  }
}
