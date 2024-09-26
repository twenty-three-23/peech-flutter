import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/platform/platform_device_info/platform_device_info.dart';

import '../widgets/show_common_dialog.dart';
import 'app_info_controller.dart';

class PlatformInfoController extends GetxController {
  final appInfoController = Get.find<AppInfoController>();

  // 디바이스 체크해서 지원하지 않는 환경이면 알림 띄워주기
  void checkDeviceRecordAvailable(BuildContext context) {
    if (PlatformDeviceInfo.isRecordUnavailableClient()) {
      showCommonDialog(
        context: context,
        title: '녹음을 지원하지 않는 환경',
        message: '사파리, IOS에서는 웹 브라우저에서 녹음 기능이 호환되지 않습니다.\n다른 플랫폼에서 이용해주세요.',
        showFirstButton: false,
        secondButtonText: '확인',
        isSecondButtonToClose: true,
      );
    }
  }

  // 모바일에서 웹에 접속한 경우 다운로드 팝업 띄우기
  void checkAppDownloadPopupOnWeb(BuildContext context) {
    if (kIsWeb) {
      if (PlatformDeviceInfo.isAndroid()) {
        showCommonDialog(
          context: context,
          title: '앱 다운로드',
          message: '모바일에서 더욱 편리하게 사용할 수 있습니다.',
          firstButtonText: '닫기',
          isFirstButtonToClose: true,
          secondButtonText: '다운로드',
          secondAction: () {
            appInfoController.gotoStore(context);
          },
        );
      }
    }
  }
}
