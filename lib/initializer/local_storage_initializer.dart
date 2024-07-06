import 'package:swm_peech_flutter/features/common/data_source/local/local_device_uuid_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_theme_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_script_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_theme_id_storage.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_token_storage.dart';

class LocalStorageInitializer {

  Future<void> initialize() async {

    await Future.wait([
      LocalScriptStorage().init(),
      LocalPracticeModeStorage().init(),
      LocalPracticeThemeStorage().init(),
      LocalUserTokenStorage().init(),
      LocalDeviceUuidStorage().init(),
      LocalThemeIdStorage().init(),
    ]);

  }

}