import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/events/social_login_event.dart';

class ShowSocialLoginEventInterceptor extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    final isStatus401 = err.response?.statusCode == 401;

    if(!isStatus401) {
      try {
        print("[ShowSocialLoginEventInterceptor] [ERR] [${err.requestOptions.method}] [${err.requestOptions.path}]");
        AppEventBus.instance.fire(SocialLoginEvent());
      } catch(e) {
        print("[ShowSocialLoginEventInterceptor] Exception: $e");
      }
    }

    return super.onError(err, handler);
  }

}