import 'package:flutter/foundation.dart';

import '../configs/amplitude_config.dart';
import '../configs/firebase_config.dart';

void logAnalytics({required String name, Map<String, dynamic>? parameters}) {
  if (kReleaseMode) {
    AmplitudeConfig.analytics.logEvent(name, eventProperties: parameters);
    FirebaseConfig.analytics.logEvent(name: name, parameters: parameters);
  }
}
