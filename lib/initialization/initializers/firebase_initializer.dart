import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:swm_peech_flutter/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics_web/firebase_analytics_web.dart'; //TODO GA for web, but not working. and make html error on android

class FirebaseInitializer {
  Future<void> initialize() async {
    print("[FirebaseInitializer] initialize");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (!kDebugMode) {
      // 디버그 모드는 Google Analytics 에서 제외
      FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    }
  }
}
