import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  Text(
                    "공예쁨",
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.15),
                  _loginButton(
                      "kakao", "카카오로 시작하기", 0xffFEE500, 0xff181503, false),
                  SizedBox(height: Get.height * 0.02),
                  _loginButton(
                      "naver", "네이버로 시작하기", 0xff06BE34, 0xffffffff, false),
                  SizedBox(height: Get.height * 0.02),
                  _loginButton(
                      "apple", "Apple로 시작하기", 0xff333D4B, 0xffffffff, false),
                  SizedBox(height: Get.height * 0.02),
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

  Container _loginButton(String? icon, String text, int backgroundColor,
      int mainColor, bool isGuest) {
    return Container(
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
    );
  }
}
