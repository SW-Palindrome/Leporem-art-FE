import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/firebase_config.dart';
import 'package:leporemart/src/screens/authentication.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';

void main() async {
  // Sentry + GlitchTip
  // kDebugMode는 개발모드일때 true, 배포모드일때 false

  Get.put(BottomNavigationbarController());
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    AmplitudeConfig.init();
    FirebaseConfig.init();
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '공예쁨',
      theme: AppTheme.lightTheme,
      home: Authentication(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseConfig.analytics),
      ],
    );
  }
}
