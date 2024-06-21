import 'package:get/get.dart';

class BeforeRecodeScriptCtr extends GetxController{

  String? _script;

  String? get script => _script;

  void updateScript(String? newScript) {
    _script = newScript;
  }

}