import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ServiceTypeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String serviceType = '';
    if (kIsWeb) {
      serviceType = 'inWeb';
    } else {
      serviceType = 'inApp';
    }
    options.headers.addAll({"serviceType": serviceType});
    print("[REQ] [ServiceTypeInterceptor] [${options.method}] [${options.path}] -> inject service type [$serviceType]");

    return super.onRequest(options, handler);
  }
}
