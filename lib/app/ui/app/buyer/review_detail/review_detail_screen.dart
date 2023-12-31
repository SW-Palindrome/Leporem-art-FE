import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/buyer/review/review_controller.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';

class ReviewDetailScreen extends GetView<ReviewController> {
  const ReviewDetailScreen({super.key});

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _descriptionInput(),
              Spacer(),
              Obx(
                () => NextButton(
                  text: '후기 작성하기',
                  value: controller.description.value != '',
                  onTap: () async {
                    logAnalytics(
                        name: 'review',
                        parameters: {'action': 'review-complete'});
                    await controller.createReview();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _descriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          '상세한 후기를 작성해주세요.',
          style: TextStyle(
            color: ColorPalette.black,
            fontWeight: FontWeight.bold,
            fontFamily: "PretendardVariable",
            fontStyle: FontStyle.normal,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: Get.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ColorPalette.grey_4,
              width: 1,
            ),
          ),
          child: Focus(
            onFocusChange: (value) {
              logAnalytics(
                  name: 'review',
                  parameters: {'action': 'description-form-focus'});
            },
            child: TextField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              maxLength: 255,
              maxLines: null,
              controller: controller.descriptionController,
              onChanged: (value) {
                controller.description.value = value;
              },
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: "PretendardVariable",
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '구매하신 작품의 후기를 남겨주시면 다른 구매자들에게도 도움이 됩니다.',
                hintMaxLines: 2,
                hintStyle: TextStyle(
                  color: ColorPalette.grey_4,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
