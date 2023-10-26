import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'app/configs/login_config.dart';
import 'app/controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import 'app/controller/common/user_global_info/user_global_info_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/ui/app/common/home/home.dart';
import 'app/ui/theme/app_theme.dart';
import 'app/utils/notification.dart';

void main() async {
  // Sentry + GlitchTip
  // kDebugMode는 개발모드일때 true, 배포모드일때 false
  if (kReleaseMode) {
    await dotenv.load(fileName: 'assets/config/.env.dev');
  } else if (kDebugMode) {
    await dotenv.load(fileName: 'assets/config/.env.dev');
  }
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 스플래시 화면 켜기
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 화면 회전 잠구기
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Get.put(UserGlobalInfoController());
  Get.lazyPut(() => MyBottomNavigationbarController());
  await initializeDateFormatting();

  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_APIKEY'));

  bool isLoginProceed = await getLoginProceed();
  await fcmSetting();

  // fcm토큰 출력
  FirebaseMessaging.instance.getToken().then((String? token) {
    assert(token != null);
    print("Push Messaging token: $token");
  });

  // if (kReleaseMode) {
  //   await AmplitudeConfig.init();
  //   SentryFlutter.init(
  //     (options) {
  //       options.dsn = dotenv.get('GLITCHTIP_DSN');
  //       options.attachStacktrace = true;
  //     },
  //     appRunner: () => runApp(MyApp(isLoginProceed: isLoginProceed)),
  //   );
  // }
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
        // if (kReleaseMode)
        //   FirebaseAnalyticsObserver(analytics: FirebaseConfig.analytics),
      ],
      getPages: AppPages.pages,
    );
  }
}
