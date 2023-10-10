import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/buyer/review/review_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';

class ReviewStarScreen extends GetView<ReviewController> {
  const ReviewStarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: Get.arguments['order'].exhibitionTitle,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: Get.arguments['order'].thumbnailImage,
                    fit: BoxFit.cover,
                    width: Get.width * 0.33,
                    height: Get.width * 0.33,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  '이 아이템 어땠나요?',
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < controller.star.value; i++)
                        GestureDetector(
                          onTap: () {
                            controller.star.value = i + 1;
                          },
                          child: SvgPicture.asset(
                            'assets/icons/star_fill.svg',
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                                ColorPalette.yellow, BlendMode.srcIn),
                          ),
                        ),
                      for (int i = controller.star.value; i < 5; i++)
                        GestureDetector(
                          onTap: () {
                            controller.star.value = i + 1;
                          },
                          child: SvgPicture.asset(
                            'assets/icons/star_fill.svg',
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                                ColorPalette.grey_4, BlendMode.srcIn),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Obx(
                  () => NextButton(
                      text: '별점 메기기',
                      onTap: () {
                        logAnalytics(name: 'review', parameters: {
                          'action': 'star ${controller.star.value}'
                        });
                        Get.toNamed(Routes.BUYER_REVIEW_STAR, arguments: {
                          'order': Get.arguments['order'],
                        });
                      },
                      value: controller.star.value != 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
