import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/screens/buyer/order_list_screen.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class ReviewCompeleteScreen extends StatelessWidget {
  const ReviewCompeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _complete(),
      ),
    );
  }

  _complete() {
    return Stack(
      children: [
        Center(
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
        Positioned(
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: NextButton(
                text: '주문 내역으로 돌아가기',
                value: true,
                onTap: () {
                  Get.offAll(BuyerOrderListScreen());
                }),
          ),
        )
      ],
    );
  }
}
