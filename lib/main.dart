import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/app.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';
import 'package:leporemart/src/controllers/bottom_navigationbar_contoller.dart';

void main() {
  Get.put(BottomNavigationbarController());
  WidgetsFlutterBinding.ensureInitialized();
  AmplitudeConfig().init();
  AmplitudeConfig.analytics.logEvent("Main Run");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    );
  }
}
