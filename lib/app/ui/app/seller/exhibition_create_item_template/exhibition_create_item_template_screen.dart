import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';
import 'widgets/design_changer_widget.dart';
import 'widgets/item_result_widget.dart';

class ExhibitionCreateItemTemplateScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateItemTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '작품 꾸미기',
        isWhite: true,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: designChangerWidget(),
              ),
              SizedBox(height: 24),
              itemResultWidget(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: NextButton(
                  text: '저장하기',
                  value: true,
                  onTap: () async {
                    if (controller.isEditingItem.value == true) {
                      await controller.editExhibitionItemById(
                          Get.arguments['exhibition_id'],
                          Get.arguments['item_id']);
                    } else {
                      await controller.createExhibitionItemById(
                          Get.arguments['exhibition_id']);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
