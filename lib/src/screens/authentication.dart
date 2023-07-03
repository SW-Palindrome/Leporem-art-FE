import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/main.dart';
import 'package:leporemart/src/app.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  void _logEvent(String eventName) async {
    await AmplitudeConfig.analytics.logEvent("Login");
    await MyApp.analytics.logLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 및 로그인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (!kDebugMode) _logEvent('비회원 로그인');
                Get.off(App());
              },
              child: Text('비회원 로그인'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logEvent('카카오 회원가입 및 로그인');
                Get.off(App());
              },
              child: Text('카카오 회원가입 및 로그인'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logEvent('구글 회원가입 및 로그인');
                Get.off(App());
              },
              child: Text('구글 회원가입 및 로그인'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logEvent('애플 회원가입 및 로그인');
                Get.off(App());
              },
              child: Text('애플 회원가입 및 로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
