import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:leporemart/app/configs/firebase_options.dart';

import '../data/provider/dio.dart';

class FirebaseConfig {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> registerFcmDevice() async {
    await DioClient().registerFcmDevice();
  }
}
