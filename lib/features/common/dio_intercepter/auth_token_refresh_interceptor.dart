import 'package:dio/dio.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_auth_token_refresh_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/auth_token_model.dart';
import 'package:swm_peech_flutter/features/common/models/refresh_token_model.dart';

class AuthTokenRefreshInterceptor extends Interceptor {

  late final LocalAuthTokenStorage localAuthTokenStorage;

  AuthTokenRefreshInterceptor({
    required this.localAuthTokenStorage
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    print("[ERR] [${err.requestOptions.method}] [${err.requestOptions.path}]");

    //AT 만료
    final isStatus410 = err.response?.statusCode == 410;

    if(isStatus410) {
      try {
        //refresh token 가져오기
        String refreshToken = localAuthTokenStorage.getRefreshToken() ?? "";
        if(refreshToken == "") {
          throw Exception("refreshToken is null!");
        }

        print('refresh token 가져오기 성공: $refreshToken');

        //토큰 재발급받기
        RefreshTokenModel refreshTokenModel = RefreshTokenModel(refreshToken: refreshToken);
        RemoteAuthTokenRefreshDataSource remoteAuthTokenRefreshDataSource = RemoteAuthTokenRefreshDataSource(AuthDioFactory().dio);
        AuthTokenModel authTokenModel = await remoteAuthTokenRefreshDataSource.refreshToken(refreshTokenModel.toJson());
        LocalAuthTokenStorage().setAccessToken(authTokenModel.accessToken ?? '');
        LocalAuthTokenStorage().setRefreshToken(authTokenModel.refreshToken ?? '');

        print('토큰 재발급 성공: ${authTokenModel.accessToken}');

        //다시 원래 요청으로 결과 받아오기
        final options = err.requestOptions;
        final reDio = AuthDioFactory().dio;
        final response = await reDio.fetch(options);
        print('다시 원래 요청으로 결과 받아오기 성공: ${response.data}');
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