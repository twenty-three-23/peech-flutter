import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';

class AuthTokenInjectInterceptor extends Interceptor {
  final LocalAuthTokenStorage localAuthTokenStorage;

  AuthTokenInjectInterceptor({required this.localAuthTokenStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    if(options.headers['accessToken'] == 'true') {
      final String? token = localAuthTokenStorage.getAccessToken();
      options.headers.addAll({"authorization": "Bearer ${token ?? 'x'}"});
      print("[REQ] [TokenInject] [${options.method}] [${options.path}] -> inject token [${token ?? 'x'}]");
    }

    return super.onRequest(options, handler);
  }

}