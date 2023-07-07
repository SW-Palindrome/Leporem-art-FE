import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
              Text(
                "가입 유형을 선택해주세요",
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: Get.height * 0.05),
              Container(
                alignment: Alignment.center,
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: true ? ColorPalette.purple : ColorPalette.grey_3,
                  ),
                  color: true
                      ? ColorPalette.purple.withAlpha(10)
                      : ColorPalette.white,
                ),
                child: Text(
                  "구매자",
                  style: TextStyle(
                    color: ColorPalette.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                alignment: Alignment.center,
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: true ? ColorPalette.purple : ColorPalette.grey_3,
                  ),
                  color: true
                      ? ColorPalette.purple.withAlpha(10)
                      : ColorPalette.white,
                ),
                child: Text(
                  "학생 판매자",
                  style: TextStyle(
                    color: ColorPalette.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Spacer(),
              NextButton(
                "다음",
                value: true,
                onTap: () {
                  Get.to(AccountType());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
