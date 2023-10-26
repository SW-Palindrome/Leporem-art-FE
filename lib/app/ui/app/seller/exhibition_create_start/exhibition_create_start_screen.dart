import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import 'widgets/exhibition_period_widget.dart';
import 'widgets/exhibition_process_widget.dart';
import 'widgets/start_inquiry_widget.dart';

class ExhibitionCreateStartScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            startInquiryWidget(),
            SizedBox(height: 40),
            exhibitionPeriodWidget(
              controller.exhibitions
                  .firstWhere(
                      (element) => element.id == Get.arguments['exhibition_id'])
                  .startDate,
              controller.exhibitions
                  .firstWhere(
                      (element) => element.id == Get.arguments['exhibition_id'])
                  .endDate,
            ),
            SizedBox(height: 40),
            exhibitionProcessWidget(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: NextButton(
                text: '시작하기',
                value: true,
                onTap: () async {
                  await controller.fetchSellerExhibitionById(
                      Get.arguments['exhibition_id']);
                  Get.toNamed(
                    Routes.SELLER_EXHIBITION_CREATE_EXHIBITION,
                    arguments: {
                      'exhibition_id': Get.arguments['exhibition_id'],
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
