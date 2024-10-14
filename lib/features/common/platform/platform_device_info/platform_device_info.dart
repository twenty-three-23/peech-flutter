import 'package:swm_peech_flutter/features/common/platform/platform_device_info/device_info_on_mobile.dart'
    if (dart.library.html) 'package:swm_peech_flutter/features/common/platform/platform_device_info/device_info_on_web.dart' as device;

class PlatformDeviceInfo {
  static get type => device.type;

  static bool isMobile() {
    return device.isMobile();
  }

  static bool isRecordUnavailableClient() {
    return device.isRecordUnavailableClient();
  }

  static bool isSafari() {
    return device.isSafari();
  }

  static bool isIOS() {
    return device.isIOS();
  }

  static bool isAndroid() {
    return device.isAndroid();
  }
}
