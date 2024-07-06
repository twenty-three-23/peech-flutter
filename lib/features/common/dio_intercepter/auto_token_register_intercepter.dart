import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';

class AutoTokenRegisterIntercepter extends Interceptor {

  late final LocalDeviceUuidStorage localDeviceUuidStorage;

  AutoTokenRegisterIntercepter({
    required this.localDeviceUuidStorage
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    final isStatus500 = err.response?.statusCode == 500;
    final isGetToken = err.requestOptions.path == "/user";
    final isGetMethod = err.requestOptions.method == "GET";

    if(isStatus500 && isGetToken && isGetMethod) {
      try {

        final options = err.requestOptions;
        options.method = "POST";
        final reDio = Dio();
        final response = await reDio.fetch(options);
        print("[ERR] [${err.requestOptions.method}] [${err.requestOptions.path}] -> [AutoTokenRegisterIntercepter] POST로 재전송 후 반환");
        return handler.resolve(response);

      } on DioException catch(e) {
        print("[AutoTokenRegisterIntercepter] DioException: $e");
        return handler.reject(e);
      } catch(e) {
        print("[AutoTokenRegisterIntercepter] Exception: $e");
        return handler.reject(DioException(requestOptions: err.requestOptions, error: e));
      }
    }

    super.onError(err, handler);
  }
}