import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/social_login_controller.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';
import 'package:swm_peech_flutter/features/common/widgets/social_login_screen.dart';

void showSocialLoginBottomSheet(BuildContext context, SocialLoginBottomSheetState state) {

  SocialLoginCtr controller = Get.put(SocialLoginCtr());
  if(controller.isShowed == true) return; // 한 번에 한개의 바텀 시트만 띄워지도록
  controller.isShowed = true;
  controller.socialLoginBottomSheetState.value = state;

  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return controller.socialLoginBottomSheetState.value == SocialLoginBottomSheetState.choiceView
          ? socialLoginScreen(context, controller)
          : Container();
    },
  ).whenComplete(() {
    Get.delete<SocialLoginCtr>();
  });
}