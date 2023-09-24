import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/configs/amplitude_config.dart';
import 'app/configs/firebase_config.dart';
import 'app/configs/login_config.dart';
import 'app/controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import 'app/controller/common/user_global_info/user_global_info_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/ui/app/common/home/home.dart';
import 'app/ui/theme/app_theme.dart';

void main() async {
  // Sentry + GlitchTip
  // kDebugMode는 개발모드일때 true, 배포모드일때 false
  if (kReleaseMode) {
    await dotenv.load(fileName: 'assets/config/.env');
  } else if (kDebugMode) {
    await dotenv.load(fileName: 'assets/config/.env');
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

  if (kReleaseMode) {
    await FirebaseConfig.init();
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

class MyApp extends StatelessWidget {
  final bool isLoginProceed;
  MyApp({super.key, required this.isLoginProceed});

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
      getPages: AppPages.pages,
    );
  }
}
