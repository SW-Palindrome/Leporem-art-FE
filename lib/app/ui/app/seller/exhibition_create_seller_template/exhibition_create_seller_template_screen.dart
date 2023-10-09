import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';
import 'widgets/design_changer_widget.dart';
import 'widgets/seller_introduction_result_widget.dart';

class ExhibitionCreateSellerTemplateScreen
    extends GetView<ExhibitionController> {
  const ExhibitionCreateSellerTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        title: '작가 소개 꾸미기',
        isWhite: true,
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                designChangerWidget(),
                SizedBox(height: 24),
                sellerIntroductionResultWidget(),
                Spacer(),
                NextButton(
                  text: '저장하기',
                  value: true,
                  onTap: () {
                    //TODO: 작가 소개 저장
                    Get.toNamed(
                      Routes.SELLER_EXHIBITION_CREATE_ITEM_COMPLETE,
                      arguments: {
                        'exhibition_id': Get.arguments['exhibition_id']
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
