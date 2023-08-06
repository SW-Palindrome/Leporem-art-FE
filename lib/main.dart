import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:leporemart/src/buyer_app.dart';
import 'package:leporemart/src/configs/firebase_config.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/controllers/account_type_controller.dart';
import 'package:leporemart/src/controllers/agreement_controller.dart';
import 'package:leporemart/src/controllers/email_controller.dart';
import 'package:leporemart/src/controllers/nickname_controller.dart';
import 'package:leporemart/src/controllers/user_global_info_controller.dart';
import 'package:leporemart/src/screens/account/login_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/chatting_socket_singleton.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';

void main() async {
  // Sentry + GlitchTip
  // kDebugMode는 개발모드일때 true, 배포모드일때 false

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(UserGlobalInfoController());

  await initializeDateFormatting();

  ChattingSocketSingleton();

  FirebaseConfig.init();
  KakaoSdk.init(nativeAppKey: '8aeac9bb18f42060a2332885577b8cb9');

  getOAuthToken().then((value) async {
    if (value != null) {
      print(
          'idToken: ${value.idToken}\naccess token: ${value.accessToken}\nrefresh token: ${value.refreshToken}');
    }
  });
  bool isLoginProceed = await isSignup();
  if (!kDebugMode) {
    AmplitudeConfig.init();
    await dotenv.load(fileName: 'assets/config/.env');

    SentryFlutter.init(
      (options) {
        options.dsn = dotenv.get('GLITCHTIP_DSN');
        options.attachStacktrace = true;
      },
      appRunner: () => runApp(MyApp(isLoginProceed: isLoginProceed)),
    );
  } else {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    runApp(MyApp(isLoginProceed: isLoginProceed));
  }
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
      home: isLoginProceed ? BuyerApp() : LoginScreen(),
      navigatorObservers: [
        if (!kDebugMode)
          FirebaseAnalyticsObserver(analytics: FirebaseConfig.analytics),
      ],
    );
  }
}
