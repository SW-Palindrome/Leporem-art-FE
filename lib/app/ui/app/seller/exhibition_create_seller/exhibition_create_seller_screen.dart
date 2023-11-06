import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/seller/exhibition_create_seller/widgets/seller_introduction_editor_widget.dart';

import '../../../../controller/seller/exhibition/seller_exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';
import 'widgets/template_select_widget.dart';

class ExhibitionCreateSellerScreen extends GetView<SellerExhibitionController> {
  const ExhibitionCreateSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        title: '작가 소개 작성',
        isWhite: true,
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () => Get.until((route) =>
            Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_START),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => SingleChildScrollView(
              child: SizedBox(
                height: Get.height * 0.835,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    templateSelectWidget(),
                    SizedBox(height: 24),
                    sellerIntroductionEditorWidget(),
                    Spacer(),
                    NextButton(
                      text: controller.isSellerTemplateUsed.value == true
                          ? '다음'
                          : '저장하기',
                      value: controller.isValidSellerSave(),
                      onTap: controller.isSellerTemplateUsed.value == true
                          ? () {
                              Get.toNamed(
                                Routes.SELLER_EXHIBITION_CREATE_SELLER_TEMPLATE,
                                arguments: {
                                  'exhibition_id':
                                      Get.arguments['exhibition_id']
                                },
                              );
                            }
                          : () async {
                              await controller.saveExhibitionArtistById(
                                  Get.arguments['exhibition_id']);
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
