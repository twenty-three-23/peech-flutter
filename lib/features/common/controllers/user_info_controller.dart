import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_audio_time_data_source.dart';
import 'package:swm_peech_flutter/features/common/models/max_audio_time_model.dart';
import 'package:swm_peech_flutter/features/common/models/remaining_time_model.dart';

import '../dio/auth_dio_factory.dart';

class UserInfoController extends GetxController {
  final Rx<RemainingTimeModel?> _remainingTime = Rx<RemainingTimeModel?>(null);
  RemainingTimeModel? get remainingTime => _remainingTime.value;

  final Rx<MaxAudioTimeModel?> _maxAudioTime = Rx<MaxAudioTimeModel?>(null);
  MaxAudioTimeModel? get maxAudioTime => _maxAudioTime.value;

  void getUserAudioTimeInfo() async {
    try {
      RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource = RemoteUserAudioTimeDataSource(AuthDioFactory().dio);
      await Future.wait([
        fetchRemainingTime(remoteUserAudioTimeDataSource),
        fetchMaxAudioTime(remoteUserAudioTimeDataSource),
      ]);
      print("[getUserAudioTimeInfo] [Success] ${_remainingTime.value?.text} ${_maxAudioTime.value?.text}");
    } on DioException catch (e) {
      print("[getUserAudioTimeInfo] [DioException] [${e.response?.statusCode}] [${e.response?.data['message']}]]");
      rethrow;
    } catch (e) {
      print("[getUserAudioTimeInfo] [Exception] $e");
      rethrow;
    }
  }

  Future<void> fetchRemainingTime(RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource) async {
    _remainingTime.value = null;
    _remainingTime.value = await remoteUserAudioTimeDataSource.getUserRemainingTime();
  }

  Future<void> fetchMaxAudioTime(RemoteUserAudioTimeDataSource remoteUserAudioTimeDataSource) async {
    _maxAudioTime.value = null;
    _maxAudioTime.value = await remoteUserAudioTimeDataSource.getUserMaxAudioTime();
  }
}
