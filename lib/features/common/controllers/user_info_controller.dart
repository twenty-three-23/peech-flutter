import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_audio_time_data_source.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/remaining_time_model.dart';

import '../dio/auth_dio_factory.dart';

class UserInfoController extends GetxController {

  RemainingTimeModel? _remainingTime;
  Rx<RemainingTimeModel?> remainingTime = Rx<RemainingTimeModel?>(null);

  MaxAudioTimeModel? _maxAudioTime;
  Rx<MaxAudioTimeModel?> maxAudioTime = Rx<MaxAudioTimeModel?>(null);

  void getUserAudioTimeInfo() async {
    try {
      remainingTime.value = null;
      maxAudioTime.value = null;
      RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource = RemoteUserAudioTimeDataSource(AuthDioFactory().dio);
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

}