import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:swm_peech_flutter/features/common/controllers/user_info_controller.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/remote/remote_user_nickname_data_source.dart';
import 'package:swm_peech_flutter/features/common/dio/auth_dio_factory.dart';
import 'package:swm_peech_flutter/features/common/models/user_nickname_model.dart';
import 'package:swm_peech_flutter/features/common/widgets/show_common_dialog.dart';

class HomeCtr extends GetxController {
  final userInfoController = Get.find<UserInfoController>();

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
    //유저 닉네임 받아오기
    UserNicknameModel userNicknameModel;

    try {
      userNicknameModel = await RemoteUserNicknameDataSource(AuthDioFactory().dio).getUserNickname();
    } catch (error) {
      print('유저 닉네임 받아오기 실패 $error');
      return;
    }

    try {
      final Email email = Email(
        body: '\n\n\n\n\n--------------------------------------------------------------\n위에 피치 서비스에 문의 또는 건의하실 내용을 입력해주세요.',
        subject: '[피치 서비스 문의] 닉네임: ${userNicknameModel.nickName}',
        recipients: ['sbin.ch04@gmail.com'],
        cc: [],
        bcc: [],
        attachmentPaths: [],
        isHTML: false,
      );
      //이메일 서비스로 연결
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('이메일 전송 실패 $error');
      String title = "이메일로 문의하기";
      String message = "아래 이메일로 연락주시면 친절하게 답변해드릴게요 :)\n\nsbin.ch04@gmail.com";
      if (context.mounted) {
        showCommonDialog(
          context: context,
          title: title,
          message: message,
          secondButtonText: '확인',
          isSecondButtonToClose: true,
          showFirstButton: false,
        );
      }
    }
  }
}
