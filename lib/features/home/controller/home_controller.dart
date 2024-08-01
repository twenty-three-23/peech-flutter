import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_audio_time_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_inject_interceptor.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/auth_token_refresh_intercepter.dart';
import 'package:swm_peech_flutter/features/common/dio_intercepter/debug_interceptor.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/remaining_time_model.dart';

class HomeCtr extends GetxController {

  @override
  onInit() {
    super.onInit();
    getUserAudioTimeInfo();
  }

  RemainingTimeModel? _remainingTime;
  Rx<RemainingTimeModel?> remainingTime = Rx<RemainingTimeModel?>(null);

  MaxAudioTimeModel? _maxAudioTime;
  Rx<MaxAudioTimeModel?> maxAudioTime = Rx<MaxAudioTimeModel?>(null);

  void getUserAudioTimeInfo() async {
    try {
      remainingTime.value = null;
      maxAudioTime.value = null;
      Dio dio = Dio();
      dio.interceptors.addAll([
        AuthTokenInjectInterceptor(localUserTokenStorage: LocalUserTokenStorage()),
        AuthTokenRefreshInterceptor(localDeviceUuidStorage: LocalDeviceUuidStorage(), localUserTokenStorage: LocalUserTokenStorage()),
        DebugIntercepter(),
      ]);
      RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource = RemoteUserAudioTimeDataSource(dio);
      await Future.wait([
        getRemainingTime(remoteUserAudioTimeDataSource),
        getMaxAudioTime(remoteUserAudioTimeDataSource),
      ]);
      remainingTime.value = _remainingTime;
      maxAudioTime.value = _maxAudioTime;
      print("[getUserAudioTimeInfo] [Success] ${remainingTime.value?.text} ${maxAudioTime.value?.text}");
    } on DioException catch(e) {
      print("[getUserAudioTimeInfo] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch(e) {
      print("[getUserAudioTimeInfo] [Exception] $e");
      rethrow;
    }
  }

  Future<void> getRemainingTime(RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource) async {
    _remainingTime = await remoteUserAudioTimeDataSource.getUserRemainingTime();
  }

  Future<void> getMaxAudioTime(RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource) async {
    _maxAudioTime =  await remoteUserAudioTimeDataSource.getUserMaxAudioTime();
  }

  void kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
      }
    } else {
      print('카카오톡이 깔려있지 않습니다.');
    }
  }

  void kakaoUnlink() async {
    try {
      await UserApi.instance.unlink();
      print('연결 끊기 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('연결 끊기 실패 $error');
    }
  }

  void kakaoLogout() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }

  }

}