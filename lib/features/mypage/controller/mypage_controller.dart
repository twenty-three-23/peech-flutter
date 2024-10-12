import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:swm_peech_flutter/features/common/constant/constants.dart';
import 'package:swm_peech_flutter/features/mypage/data_source/remote/remote_user_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/data_source/local/local_auth_token_storage.dart';
import '../../common/dio/auth_dio_factory.dart';


class MyPageController extends GetxController {

  void logOut() async {
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

  void deleteUser() async {
    LocalAuthTokenStorage().removeAllAuthToken();
    var remoteUserDataSource = RemoteUserDataSource(AuthDioFactory().dio);
      await remoteUserDataSource.deleteUser();
  }

}