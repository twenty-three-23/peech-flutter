import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCtr extends GetxController {

  final userInfoController = Get.find<UserInfoController>();

  @override
  onInit() {
    userInfoController.getUserAudioTimeInfo();
    super.onInit();
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

  void logOut() async {
    LocalAuthTokenStorage().removeAllAuthToken();
  }

  void contactToEmail(BuildContext context) async {
    final Email email = Email(
      body: '',
      subject: '[피치 서비스 문의]',
      recipients: ['sbin.ch04@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('이메일 전송 실패 $error');
      String title = "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.";
      String message = "아래 이메일로 연락주시면 친절하게 답변해드릴게요 :)\n\nsbin.ch04@gmail.com";
      if(context.mounted) {
        showCommonDialog(
          context: context,
          title: title,
          message: message,
          secondButtonText: '확인',
          secondAction: () { Navigator.of(context).pop(); },
          showFirstButton: false
        );
      }
    }
  }


}