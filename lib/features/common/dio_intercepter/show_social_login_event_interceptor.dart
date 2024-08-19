import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/event_bus/app_event_bus.dart';
import 'package:swm_peech_flutter/features/common/events/social_login_bottom_sheet_open_event.dart';
import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';

class ShowSocialLoginEventInterceptor extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    final isStatus401 = err.response?.statusCode == 401;
    final isStatus411 = err.response?.statusCode == 411;

    //소셜 로그인 바텀 시트(소셜 로그인 선택 뷰) 띄우기
    if(isStatus401) {
      try {
        print("[ShowSocialLoginEventInterceptor] [ERR] [${err.requestOptions.method}] [${err.requestOptions.path}]");
        AppEventBus.instance.fire(SocialLoginBottomSheetOpenEvent(socialLoginBottomSheetState: SocialLoginBottomSheetState.choiceView, fromWhere: 'ShowSocialLoginEventInterceptor-is401'));
      } catch(e) {
        print("[ShowSocialLoginEventInterceptor] Exception: $e");
      }
    }

    //소셜 로그인 바텀 시트(추가 정보 입력 뷰) 띄우기
    if(isStatus411) {
      try {
        print("[ShowSocialLoginEventInterceptor] [ERR] [${err.requestOptions.method}] [${err.requestOptions.path}]");
        AppEventBus.instance.fire(SocialLoginBottomSheetOpenEvent(socialLoginBottomSheetState: SocialLoginBottomSheetState.gettingAdditionalDataView, fromWhere: 'ShowSocialLoginEventInterceptor-is411'));
      } catch(e) {
        print("[ShowSocialLoginEventInterceptor] Exception: $e");
      }
    }

    return super.onError(err, handler);
  }

}