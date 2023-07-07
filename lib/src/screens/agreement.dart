import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class Agreement extends StatelessWidget {
  const Agreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.15),
              Text(
                "개인정보 약관 동의 후\n서비스를 이용할 수 있어요.",
                style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: Get.height * 0.05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffF5F5F5),
                ),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(12),
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/checkbox_select.svg',
                        width: 24,
                      ),
                    ),
                    Text(
                      "모두 동의합니다.",
                      style: TextStyle(
                          color: Color(0xff515A68),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              agreeRow("개인정보 수집 및 동의 ", true, true),
              agreeRow("개인정보 수집 및 동의 ", false, false),
              Spacer(),
              Container(
                width: Get.width,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorPalette.purple,
                ),
                child: Center(
                  child: Text(
                    "다음",
                    style: TextStyle(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row agreeRow(String text, bool isRequired, bool isChecked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(),
          onPressed: () {},
          icon: SvgPicture.asset(
            isChecked
                ? 'assets/icons/checkbox_select.svg'
                : 'assets/icons/checkbox_unselect.svg',
            width: 24,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: TextStyle(
                    color: Color(isChecked ? 0xff191f28 : 0xff515a68),
                    fontWeight: FontWeight.w500,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
                text: text,
              ),
              TextSpan(
                style: TextStyle(
                    color: ColorPalette.purple,
                    fontWeight: FontWeight.w500,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
                text: isRequired ? "(필수)" : "(선택)",
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: RichText(
            text: TextSpan(
              text: '보기',
              style: TextStyle(
                color: Color(0xffadb3be),
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                decoration: TextDecoration.underline, // 밑줄 스타일 추가
              ),
            ),
          ),
        ),
      ],
    );
  }
}
