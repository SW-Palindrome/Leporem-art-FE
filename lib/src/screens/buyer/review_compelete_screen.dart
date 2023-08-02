import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class ReviewCompeleteScreen extends StatelessWidget {
  const ReviewCompeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: _complete(),
      ),
    );
  }

  _complete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/complete.svg',
                width: Get.width * 0.22,
                height: Get.width * 0.22,
              ),
              SizedBox(height: 40),
              Text(
                '후기 작성을 완료했습니다!',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPalette.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontPalette.pretenderd,
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: NextButton(
            text: '주문 내역으로 돌아가기',
            value: true,
            onTap: () {
              Get.back();
            },
            width: Get.width,
          ),
        ),
      ],
    );
  }
}
