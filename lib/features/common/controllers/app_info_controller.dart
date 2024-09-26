import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_app_info_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/app_info_model.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoController extends GetxController {
  int? appMinVersion;
  bool? appAvailable;

  final String _androidAppId = "com.twenty_three.swm_peech_flutter"; // Android 패키지 이름
  final String _iosAppId = "none"; // TODO iOS 앱스토어 ID

  Uri _getStoreUrl(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Uri.parse("https://apps.apple.com/app/$_iosAppId");
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return Uri.parse("https://play.google.com/store/apps/details?id=$_androidAppId");
    }
    return Uri.parse("");
  }

  void gotoStore(BuildContext context) async {
    final Uri url = _getStoreUrl(context);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw '[gotoStore] Could not launch $url';
    }
  }

  Future<bool> checkAppAvailableTest(BuildContext context) async {
    showCommonDialog(
        context: context,
        title: '앱을 사용할 수 없습니다',
        message: '앱이 점검 중에 있습니다\n나중에 다시 시도해 주세요',
        barrierDismissible: false,
        showFirstButton: false,
        secondButtonText: '확인',
        secondAction: () {
          SystemNavigator.pop(); // 앱 종료
        });
    return false;
  }

  Future<void> checkAppInfo(BuildContext context) async {
    await getAppInfo();
    print('appMinVersion: $appMinVersion');
    print('appAvailable: $appAvailable');
    if (context.mounted) {
      if (await checkAppUpdate(context) == false) return; // 앱 강제 업데이트
    }
    if (context.mounted) {
      if (await checkAppAvailable(context) == false) return; // 앱 사용 불가
    }
  }

  Future<void> getAppInfo() async {
    AppInfoModel appInfoModel = await RemoteAppInfoDataSource(AuthDioFactory().dio).getAppInfo();
    appMinVersion = int.parse(appInfoModel.appMinVersion);
    appAvailable = appInfoModel.appAvailable;
  }

  Future<bool> checkAppAvailable(BuildContext context) async {
    if (appAvailable == false) {
      if (context.mounted) {
        showCommonDialog(
            context: context,
            title: '앱을 사용할 수 없습니다',
            message: '앱이 점검 중에 있습니다\n나중에 다시 시도해 주세요',
            barrierDismissible: false,
            showFirstButton: false,
            secondButtonText: '확인',
            secondAction: () {
              SystemNavigator.pop(); // 앱 종료
            });
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAppUpdate(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(packageInfo.buildNumber);
    print('현재 버전: $currentVersion / 최소 버전: $appMinVersion');
    if (currentVersion < (appMinVersion ?? 0)) {
      if (context.mounted) {
        showCommonDialog(
            context: context,
            title: '앱 업데이트',
            message: '새로운 버전이 출시되었습니다\n업데이트 후 이용해주세요',
            barrierDismissible: false,
            showFirstButton: false,
            secondButtonText: '업데이트',
            secondAction: () async {
              gotoStore(context);
            });
        return false;
      }
    }
    return true;
  }
}
