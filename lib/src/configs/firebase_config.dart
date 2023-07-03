import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:leporemart/firebase_options.dart';

class FirebaseConfig {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static void init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
