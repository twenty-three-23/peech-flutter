import 'package:firebase_core/firebase_core.dart';
import 'package:swm_peech_flutter/firebase_options.dart';

class FirebaseInitializer {

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

}