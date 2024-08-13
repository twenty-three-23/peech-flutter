import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';

class AuthTokenInjectInterceptor extends Interceptor {
  final LocalAuthTokenStorage localAuthTokenStorage;

  AuthTokenInjectInterceptor({required this.localAuthTokenStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    if(options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      String? token = localAuthTokenStorage.getAccessToken();
      if(token == '' || token == null) {
        token = 'x';
      }
      options.headers.addAll({"authorization": "Bearer $token"});
      print("[REQ] [TokenInject] [${options.method}] [${options.path}] -> inject token [$token]");
    }

    return super.onRequest(options, handler);
  }

}