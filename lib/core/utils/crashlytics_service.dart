import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  const CrashlyticsService._();

  static Future<void> triggerTestCrash() async {
    if (!kDebugMode) {
      return;
    }

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.crash();
  }
}
