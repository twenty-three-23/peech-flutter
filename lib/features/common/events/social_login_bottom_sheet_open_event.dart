import 'package:swm_peech_flutter/features/common/models/social_login_bottom_sheet_state.dart.dart';

class SocialLoginBottomSheetOpenEvent {
  SocialLoginBottomSheetState socialLoginBottomSheetState;
  String fromWhere;

  SocialLoginBottomSheetOpenEvent({required this.socialLoginBottomSheetState, this.fromWhere = 'unknwon'});
}