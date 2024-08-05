import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/controllers/social_login_controller.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';
import 'package:swm_peech_flutter/features/common/widgets/social_login_choice_view.dart';

import 'social_getting_additional_info_view.dart';

void showSocialLoginBottomSheet(BuildContext context, SocialLoginBottomSheetState state) {
  SocialLoginCtr controller = Get.put(SocialLoginCtr());
  controller.socialLoginBottomSheetState.value = state;
  if (controller.isShowed == true) return; // 한 번에 한개의 바텀 시트만 띄워지도록
  controller.isShowed = true;

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets, // 키보드 높이만큼 패딩 추가
        child: SingleChildScrollView(
          child: GetX<SocialLoginCtr>(
            builder: (_) => controller.socialLoginBottomSheetState.value == SocialLoginBottomSheetState.choiceView
                ? socialLoginChoiceView(context, controller)
                : socialGettingAdditionalInfoView(context, controller),
          ),
        ),
      );
    },
  ).whenComplete(() {
    Get.delete<SocialLoginCtr>();
    controller.isShowed = false; // Bottom Sheet가 닫히면 상태를 초기화
  });
}