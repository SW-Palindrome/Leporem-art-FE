import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:leporemart/src/configs/firebase_config.dart';
import 'package:leporemart/src/configs/firebase_options.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:leporemart/src/screens/account/home.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/chatting_socket_singleton.dart';
import 'package:leporemart/src/utils/notification.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';

void main() async {
  // Sentry + GlitchTip
  // kDebugMode는 개발모드일때 true, 배포모드일때 false
  if (kReleaseMode) {
    await dotenv.load(fileName: 'assets/config/.env');
  } else if (kDebugMode) {
    await dotenv.load(fileName: 'assets/config/.env.dev');
  }
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(UserGlobalInfoController());
  Get.lazyPut(() => MyBottomNavigationbarController());
  await initializeDateFormatting();

  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_APIKEY'));

  bool isLoginProceed = await getLoginProceed();
  await FirebaseConfig.init();

  // setting 함수
  await setupFlutterNotifications();

  if (kReleaseMode) {
    await AmplitudeConfig.init();
    SentryFlutter.init(
      (options) {
        options.dsn = dotenv.get('GLITCHTIP_DSN');
        options.attachStacktrace = true;
      },
      appRunner: () => runApp(MyApp(isLoginProceed: isLoginProceed)),
    );
  }
  runApp(MyApp(isLoginProceed: isLoginProceed));
}

class MyApp extends StatefulWidget {
  final bool isLoginProceed;
  MyApp({super.key, required this.isLoginProceed});
  @override
  State<MyApp> createState() => _MyAppState(isLoginProceed: isLoginProceed);
}

class _MyAppState extends State<MyApp> {
  final bool isLoginProceed;
  _MyAppState({required this.isLoginProceed});

  @override
  void initState() {
    super.initState();
    // foreground 수신처리
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // background 수신처리
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '공예쁨',
      theme: AppTheme.lightTheme,
      home: HomeScreen(isLoginProceed: isLoginProceed),
      navigatorObservers: [
        if (kReleaseMode)
          FirebaseAnalyticsObserver(analytics: FirebaseConfig.analytics),
      ],
    );
  }
}
