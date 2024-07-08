import 'package:dio/dio.dart';

class DebugIntercepter extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("[REQ] [DebugIntercepter] [${options.method}] [${options.path}]");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("[RES] [DebugIntercepter] [${response.requestOptions.method}] [${response.requestOptions.path}] [${response.statusCode}] [${response.data}]");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("[ERR] [DebugIntercepter] [${err.requestOptions.method}] [${err.requestOptions.path}] [${err.response?.statusCode}] [${err.response?.data}]");
    return super.onError(err, handler);
  }
}