import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../configs/login_config.dart';
import '../../../../controller/account/nickname/nickname_controller.dart';
import '../../../../controller/common/user_global_info/user_global_info_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/log_analytics.dart';
import '../../common/home/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _logEvent(String eventName) async {
    logAnalytics(name: "login", parameters: {"action": eventName});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/app_description.png',
                    width: Get.width * 0.47,
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/app_title.png',
                    width: Get.width * 0.38,
                  ),
                  SizedBox(height: Get.height * 0.3),
                  _loginButton(
                      "kakao", "카카오로 시작하기", 0xffFEE500, 0xff181503, false),
                  SizedBox(height: Get.height * 0.02),
                  // _loginButton(
                  //     "naver", "네이버로 시작하기", 0xff06BE34, 0xffffffff, false),
                  // SizedBox(height: Get.height * 0.02),
                  if (Platform.isIOS)
                    _loginButton(
                        "apple", "Apple로 시작하기", 0xff333D4B, 0xffffffff, false),
                  if (Platform.isIOS) SizedBox(height: Get.height * 0.02),
                  _loginButton(
                      null, "회원가입 없이 시작하기", 0xffffffff, 0xff191f28, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginButton(
    String? icon,
    String text,
    int backgroundColor,
    int mainColor,
    bool isGuest,
  ) {
    return GestureDetector(
      onTap: () async {
        switch (icon) {
          case 'kakao':
            Get.find<NicknameController>().loginPlatform = LoginPlatform.kakao;
            Get.find<UserGlobalInfoController>().userType = UserType.member;
            await kakaoLogin();
            break;
          case 'naver':
            break;
          case 'apple':
            final credential = await SignInWithApple.getAppleIDCredential(
              scopes: [],
            );
            if (await isSignup(
                LoginPlatform.apple, credential.authorizationCode)) {
              Get.offAll(HomeScreen(isLoginProceed: true));
            } else {
              Get.find<NicknameController>().loginPlatform =
                  LoginPlatform.apple;
              Get.find<NicknameController>().userIdentifier =
                  credential.userIdentifier!;
              Get.toNamed(Routes.AGREEMENT);
            }
            break;
          case null:
            Get.find<UserGlobalInfoController>().userType = UserType.guest;
            Get.toNamed(Routes.BUYER_APP);
        }
        _logEvent('$icon 회원가입 및 로그인');
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Color(backgroundColor),
          borderRadius: BorderRadius.circular(10),
          border:
              isGuest ? Border.all(color: Color(0xff191f28), width: 0.1) : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Color(mainColor),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              if (!isGuest)
                Positioned(
                  left: 24,
                  child: Image.asset(
                    'assets/icons/$icon.png',
                    width: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
