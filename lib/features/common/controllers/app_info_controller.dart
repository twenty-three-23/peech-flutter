import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_app_info_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/app_info_model.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';

class AppInfoController extends GetxController {

  String? appMinVersion;
  bool? appAvailable;

  Future<void> checkAppInfoTest(BuildContext context) async {
    showCommonDialog(
      context: context,
      title: '앱을 사용할 수 없습니다',
      message: '앱이 점검 중에 있습니다\n나중에 다시 시도해 주세요',
      barrierDismissible: false,
      showFirstButton: false,
      secondButtonText: '확인',
      secondAction: () {
        if (context.mounted) {
          Navigator.of(context).pop(true);  // 다이얼로그 종료
        }
        Future.delayed(const Duration(milliseconds: 100), () {
          SystemNavigator.pop();  // 앱 종료
        });
      }
    );
  }

  Future<void> checkAppInfo(BuildContext context) async {
    await getAppInfo();
    print('appMinVersion: $appMinVersion');
    print('appAvailable: $appAvailable');
    if(appAvailable == true) {
      if(context.mounted) {
        showCommonDialog(
          context: context,
          title: '앱을 사용할 수 없습니다',
          message: '앱이 점검 중에 있습니다\n나중에 다시 시도해 주세요',
          barrierDismissible: false,
          showFirstButton: false,
          secondButtonText: '확인',
          secondAction: () {
            if (context.mounted) {
              Navigator.of(context).pop(true);  // 다이얼로그 종료
            }
            Future.delayed(const Duration(milliseconds: 100), () {
              SystemNavigator.pop();  // 앱 종료
            });
          }
        );
      }

      // Get.defaultDialog(
      //   title: "앱 업데이트",
      //   middleText: "새로운 버전이 출시되었습니다. 업데이트 후 사용해주세요.",
      //   textConfirm: "업데이트",
      //   onConfirm: () {
      //
      // }
    }
  }

  Future<void> getAppInfo() async {
    AppInfoModel appInfoModel = await RemoteAppInfoDataSource(AuthDioFactory().dio).getAppInfo();
    appMinVersion = appInfoModel.appMinVersion;
    appAvailable = appInfoModel.appAvailable;
  }

}