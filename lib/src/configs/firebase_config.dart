import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:leporemart/src/configs/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/dio_singleton.dart';

class FirebaseConfig {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}

Future<void> registerFcmDevice() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  final response = await DioSingleton.dio.post(
    '/notifications/register',
    data: {
      'fcm_token' : fcmToken,
    },
    options: Options(
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    ),
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to register fcm device');
  }
}
