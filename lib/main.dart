import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:leporemart/firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:leporemart/src/app.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';

void main() async {
  Get.put(BottomNavigationbarController());
  WidgetsFlutterBinding.ensureInitialized();
  await AmplitudeConfig().init();
  AmplitudeConfig.analytics.logEvent("Main Run");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Sentry + GlitchTip
  // kDebugMode는 개발모드일때 true, 배포모드일때 false
  if (kDebugMode == true) {
    await dotenv.load(fileName: 'assets/config/.env');
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.get('GLITCHTIP_DSN');
        options.attachStacktrace = true;
      },
      appRunner: () => runApp(MyApp()),
    );
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '공예쁨',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      home: App(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
