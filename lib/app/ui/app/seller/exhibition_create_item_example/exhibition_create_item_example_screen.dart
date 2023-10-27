import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import 'widgets/exhibition_item_example_text_widget.dart';
import 'widgets/exhibition_template_carousel_widget.dart';

class ExhibitionCreateItemExampleScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateItemExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        isWhite: true,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            exhibitionItemExampleTextWidget(),
            SizedBox(height: 24),
            exhibitionTemplateCarouselWidget(),
            SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: NextButton(
                value: true,
                text: '선택하기',
                onTap: () {
                  //TODO: 템플릿 선택 후 다음 페이지로 이동
                  Get.toNamed(
                    Routes.SELLER_EXHIBITION_CREATE_ITEM,
                    arguments: {
                      'exhibition_id': Get.arguments['exhibition_id'],
                    },
                  );
                  controller.isItemTemplateUsed.value = true;
                  controller.isItemTemplateUsed.refresh();
                },
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: () {
                  controller.resetItemInfo();
                  Get.toNamed(Routes.SELLER_EXHIBITION_CREATE_ITEM);
                  controller.isItemTemplateUsed.value = false;
                },
                child: Text(
                  '템플릿을 사용하지 않을게요.',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: ColorPalette.grey_5,
                    fontFamily: FontPalette.pretendard,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
