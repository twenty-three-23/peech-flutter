import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';

class AuthTokenInjectInterceptor extends Interceptor {
  final LocalUserTokenStorage localUserTokenStorage;

  AuthTokenInjectInterceptor({required this.localUserTokenStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    if(options.headers['accessToken'] == 'true') {
      final String? token = localUserTokenStorage.getUserToken();
      options.headers.addAll({"authorization": "Bearer ${token ?? 'x'}"});
      print("[REQ] [TokenInject] [${options.method}] [${options.path}] -> inject token [${token ?? 'x'}]");
    }

    return super.onRequest(options, handler);
  }

}