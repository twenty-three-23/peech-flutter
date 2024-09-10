import 'package:firebase_core/firebase_core.dart';
import 'package:swm_peech_flutter/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics_web/firebase_analytics_web.dart'; //TODO GA for web, but not working. and make html error on android

class FirebaseInitializer {
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  }
}
