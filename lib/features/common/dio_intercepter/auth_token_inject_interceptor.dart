import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';

class AuthTokenInjectInterceptor extends Interceptor {
  final LocalUserTokenStorage localUserTokenStorage;

  AuthTokenInjectInterceptor({required this.localUserTokenStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {


    final token = localUserTokenStorage.getUserToken();

    options.headers.addAll({"authorization": "Bearer $token"});

    print("[REQ] [TokenInject] [${options.method}] [${options.path}] -> inject token [$token]");
    return super.onRequest(options, handler);
  }

}