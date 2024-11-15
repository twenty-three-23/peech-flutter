import 'package:swm_peech_flutter/features/common/data_source/local/local_auth_token_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_review_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_info_storage.dart';

class LocalStorageInitializer {
  Future<void> initialize() async {
    print("[LocalStorageInitializer] initialize");
    await Future.wait([
      LocalUserInfoStorage().init(),
      LocalScriptStorage().init(),
      LocalPracticeModeStorage().init(),
      LocalPracticeThemeStorage().init(),
      LocalAuthTokenStorage().init(),
      LocalReviewStorage().init(),
      LocalDeviceUuidStorage().init(),
    ]);
  }
}
