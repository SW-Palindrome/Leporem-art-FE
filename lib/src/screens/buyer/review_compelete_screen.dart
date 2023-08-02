import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

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
    return Center(
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/complete.svg'),
          SizedBox(height: 40),
          Text('후기 작성을 완료했습니다!',
              style: TextStyle(
                fontSize: 20,
                color: ColorPalette.black,
                fontFamily: FontPalette.pretenderd,
              )),
        ],
      ),
    );
  }
}
