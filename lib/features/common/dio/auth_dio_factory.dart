import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auto_register_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/debug_interceptor.dart';

class AuthDioFactory {
  Dio get dio {
    Dio dio = Dio();

    dio.interceptors.addAll([
      AuthTokenInjectInterceptor(localAuthTokenStorage: LocalAuthTokenStorage()),
      AutoTokenRegisterIntercepter(localDeviceUuidStorage: LocalDeviceUuidStorage()),
      DebugIntercepter(),
    ]);

    return dio;
  }
}