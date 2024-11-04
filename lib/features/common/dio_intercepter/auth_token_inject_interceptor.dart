import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';

class AuthTokenInjectInterceptor extends Interceptor {
  final LocalAuthTokenStorage localAuthTokenStorage;

  AuthTokenInjectInterceptor({required this.localAuthTokenStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["ngrok-skip-browser-warning"] = '100'; // ngrok 사용할 때 브라우저 경고창 무시

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      String? token = localAuthTokenStorage.getAccessToken();
      if (token == '' || token == null) {
        token = 'x';
      }
      options.headers.addAll({"authorization": "Bearer $token"});
      print("[REQ] [TokenInject] [${options.method}] [${options.path}] -> inject access token [$token]");
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');
      String? token = localAuthTokenStorage.getRefreshToken();
      if (token == '' || token == null) {
        token = 'x';
      }
      options.headers.addAll({"authorization": "Bearer $token"});
      print("[REQ] [TokenInject] [${options.method}] [${options.path}] -> inject refresh token [$token]");
    }

    return super.onRequest(options, handler);
  }
}
