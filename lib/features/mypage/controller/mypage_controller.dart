import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
import 'package:swm_peech_flutter/features/mypage/data_source/remote/remote_user_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/data_source/local/local_auth_token_storage.dart';
import '../../common/dio/auth_dio_factory.dart';

class MyPageController extends GetxController {
  final userInfoController = Get.find<UserInfoController>();

  // 바텀 네비게이션 통해서 진입시 실행되는 함수
  void enter() {
    userInfoController.fetchUserNickname();
    userInfoController.getUserAudioTimeInfo();
  }

  void logOutButton(BuildContext context) async {
    showCommonDialog(
      context: context,
      title: '로그아웃',
      message: '정말 로그아웃하시겠습니까?',
      isFirstButtonToClose: true,
      firstButtonText: '취소',
      secondButtonText: '로그아웃',
      isSecondButtonToClose: true,
      secondAction: () {
        _logOut();
        Navigator.of(context).pushNamed('/root');
        Get.snackbar('로그아웃', '로그아웃이 완료되었습니다.');
      },
    );
  }

  void _logOut() async {
    LocalAuthTokenStorage().removeAllAuthToken();
  }

  void gotoAnnouncement() async {
    Uri inquiryUri = Uri.parse(Constants.announcementUrl);

    if (await canLaunchUrl(inquiryUri)) {
      await launchUrl(inquiryUri, mode: LaunchMode.inAppWebView);
    } else {
      throw '[gotoAnnouncement] Could not launch $inquiryUri';
    }
  }

  void gotoUsageGuide() async {
    Uri usageGuideUri = Uri.parse(Constants.usageGuideUrl);

    if (await canLaunchUrl(usageGuideUri)) {
      await launchUrl(usageGuideUri, mode: LaunchMode.inAppWebView);
    } else {
      throw '[gotoUsageGuide] Could not launch $usageGuideUri';
    }
  }

  void gotoPrivacyPolicy() async {
    Uri privacyPolicyUri = Uri.parse(Constants.privacyPolicyUrl);

    if (await canLaunchUrl(privacyPolicyUri)) {
      await launchUrl(privacyPolicyUri, mode: LaunchMode.inAppWebView);
    } else {
      throw '[gotoPrivacyPolicy] Could not launch $privacyPolicyUri';
    }
  }

  void _deleteUser() async {
    LocalAuthTokenStorage().removeAllAuthToken();
    var remoteUserDataSource = RemoteUserDataSource(AuthDioFactory().dio);
    await remoteUserDataSource.deleteUser();
  }

  void deleteUserButton(BuildContext context) {
    showCommonDialog(
      context: context,
      title: '회원탈퇴',
      message: '정말 회원탈퇴하시겠습니까?',
      isFirstButtonToClose: true,
      firstButtonText: '취소',
      secondButtonText: '회원탈퇴',
      isSecondButtonToClose: true,
      secondAction: () {
        _deleteUser();
        Navigator.of(context).pushNamed('/root');
        Get.snackbar('회원탈퇴', '회원탈퇴가 완료되었습니다.');
      },
    );
  }
}
