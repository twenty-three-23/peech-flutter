import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/platform/is_mobile_on_mobile.dart'
    if (dart.library.html) 'package:swm_peech_flutter/features/common/platform/is_mobile_on_web.dart' as platform_client;

import '../widgets/show_common_dialog.dart';

class PlatformInfoController extends GetxController {
  // 디바이스 체크해서 지원하지 않는 환경이면 알림 띄워주기
  void checkDeviceRecordAvailable(BuildContext context) {
    if (platform_client.isUnavailableClient()) {
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
}
