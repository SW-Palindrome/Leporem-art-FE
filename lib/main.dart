import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:leporemart/src/app.dart';
import 'package:leporemart/src/configs/firebase_config.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/controllers/account_type_controller.dart';
import 'package:leporemart/src/controllers/agreement_controller.dart';
import 'package:leporemart/src/controllers/email_controller.dart';
import 'package:leporemart/src/controllers/home_controller.dart';
import 'package:leporemart/src/controllers/item_create_detail_controller.dart';
import 'package:leporemart/src/controllers/item_detail_controller.dart';
import 'package:leporemart/src/controllers/nickname_controller.dart';
import 'package:leporemart/src/screens/item_create_screen.dart';
import 'package:leporemart/src/screens/item_detail_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
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
  Get.put(BottomNavigationbarController());
  Get.put(AgreementController());
  Get.put(AccountTypeController());
  Get.put(EmailController());
  Get.put(NicknameController());
  Get.put(ItemDetailController());
  Get.put(ItemCreateDetailController());
  Get.put(HomeController());
  FirebaseConfig.init();
  KakaoSdk.init(nativeAppKey: '8aeac9bb18f42060a2332885577b8cb9');

  getIDToken().then((value) {
    print(value);
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
      home: ItemCreateScreen(), // isLoginProceed ? App() : LoginScreen(),
      navigatorObservers: [
        if (!kDebugMode)
          FirebaseAnalyticsObserver(analytics: FirebaseConfig.analytics),
      ],
    );
  }
}
