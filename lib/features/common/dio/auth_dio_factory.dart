import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_refresh_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/debug_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/show_social_login_event_interceptor.dart';

class AuthDioFactory {
  Dio get dio {
    Dio dio = Dio();

    dio.interceptors.addAll([
      AuthTokenInjectInterceptor(localAuthTokenStorage: LocalAuthTokenStorage()),
      AuthTokenRefreshInterceptor(localAuthTokenStorage: LocalAuthTokenStorage()),
      ShowSocialLoginEventInterceptor(),
      DebugIntercepter(),
    ]);

    return dio;
  }
}