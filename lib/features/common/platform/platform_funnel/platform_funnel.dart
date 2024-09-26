import 'package:swm_peech_flutter/features/common/platform/platform_funnel/funnel_on_mobile.dart'
    if (dart.library.html) 'package:swm_peech_flutter/features/common/platform/platform_funnel/funnel_on_web.dart' as funnel;

class PlatformFunnel {
  static String getFunnel() {
    return funnel.getFunnel();
  }
}
