
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/data_source/local/local_auth_token_storage.dart';


class MyPageController extends GetxController {

  void logOut() async {
    LocalAuthTokenStorage().removeAllAuthToken();
  }

}