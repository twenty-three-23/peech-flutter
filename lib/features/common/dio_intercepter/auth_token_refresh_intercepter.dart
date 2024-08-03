import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_id_assign_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auto_token_register_intercepter.dart';
import 'package:swm_peech_flutter/features/common/models/device_id_model.dart';
import 'package:swm_peech_flutter/features/common/models/user_token_model.dart';

class AuthTokenRefreshInterceptor extends Interceptor {

  late final LocalDeviceUuidStorage localDeviceUuidStorage;
  late final LocalUserTokenStorage localUserTokenStorage;

  AuthTokenRefreshInterceptor({
    required this.localDeviceUuidStorage,
    required this.localUserTokenStorage
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    print("[ERR] [${err.requestOptions.method}] [${err.requestOptions.path}]");

    final isStatus401 = err.response?.statusCode == 401;
    final isGetToken = err.requestOptions.path == "api/v1/user";

    if(isStatus401 && !isGetToken) {
      DeviceIdModel deviceIdModel = DeviceIdModel();
      //TODO deviceId null 처리 어떻게 해야 좋을까
      try {
        //device id 가져오기
        deviceIdModel.deviceId = await localDeviceUuidStorage.getDeviceUuid();
        if(deviceIdModel.deviceId == null) {
          throw Exception("can't found device id");
        }

        //토큰 재발급받기
        final tokenDio = Dio();
        tokenDio.interceptors.add(AutoTokenRegisterIntercepter(localDeviceUuidStorage: localDeviceUuidStorage));
        final remoteUserTokenDataSource = RemoteUserTokenDataSource(tokenDio);
        final UserTokenModel tokenModel = await remoteUserTokenDataSource.getUserToken(deviceIdModel.toJson());
        await localUserTokenStorage.setUserToken(tokenModel.token!);

        //다시 원래 요청으로 결과 받아오기
        final options = err.requestOptions;
        final reDio = Dio();
        reDio.interceptors.add(AuthTokenInjectInterceptor(localAuthTokenStorage: LocalAuthTokenStorage()));
        final response = await reDio.fetch(options);
        return handler.resolve(response);

      } on DioException catch(e) {
        print("[AuthTokenRefreshInterceptor] message: [${e.response?.data['message']}] DioException: $e");
        return handler.reject(e);
      } catch(e) {
        print("[AuthTokenRefreshInterceptor] Exception: $e");
        return handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: e,
        ));
      }


    }


    return super.onError(err, handler);
  }

}