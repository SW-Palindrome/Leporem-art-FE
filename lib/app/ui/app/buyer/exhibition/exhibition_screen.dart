import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';
import '../../seller/exhibition/widgets/empty_exhibition_widgets.dart';
import 'widgets/exhibition_carousel_widget.dart';

class BuyerExhibitionScreen extends StatelessWidget {
  const BuyerExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '기획전',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 24),
          if (controller.exhibitions.isEmpty)
            emptyExhibitionWidget()
          else
            exhibitionCarouselWidget()
        ],
      ),
    );
  }
}
