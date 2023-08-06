import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/configs/firebase_config.dart';

void logAnalytics({required String name, Map<String, dynamic>? parameters}) {
  AmplitudeConfig.analytics.logEvent(name, eventProperties: parameters);
  FirebaseConfig.analytics.logEvent(name: name, parameters: parameters);
}
