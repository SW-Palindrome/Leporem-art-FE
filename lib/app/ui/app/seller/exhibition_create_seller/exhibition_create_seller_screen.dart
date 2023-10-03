import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import 'widgets/seller_thumbnail_input_widget.dart';
import 'widgets/template_select_widget.dart';

class ExhibitionCreateSellerScreen extends StatelessWidget {
  const ExhibitionCreateSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          GestureDetector(
            onTap: () => print('미리보기'),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '미리보기',
                  style: TextStyle(
                    color: ColorPalette.grey_4,
                    fontFamily: FontPalette.pretenderd,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              templateSelectWidget(),
              SizedBox(height: 40),
              sellerThumbnailInputWidget(),
              Spacer(),
              NextButton(
                text: '저장하기',
                value: false,
                onTap: () {},
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
