import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/seller/exhibition_create_item_complete/widgets/exhibition_item_complete_text_widget.dart';
import 'package:leporemart/app/ui/app/seller/exhibition_create_item_complete/widgets/exhibition_item_edit_widget.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/next_button.dart';
import 'widgets/exhibition_item_list_widget.dart';

class ExhibitionCreateItemCompleteScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateItemCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.grey_1,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.until((route) =>
              Get.currentRoute == Routes.SELLER_EXHIBITION_CREATE_START);
        },
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Obx(() => controller.isEditingItemList.value ?
                  GestureDetector(
                    onTap: () {
                      controller.isEditingItemList.value = false;
                      controller.isEditingItemList.refresh();
                    },
                    child: Text(
                      '완료',
                      style: TextStyle(
                        color: ColorPalette.grey_4,
                        fontSize: 16,
                      ),
                    ),
                  ) : GestureDetector(
                    onTap: () {
                      controller.isEditingItemList.value = true;
                      controller.isEditingItemList.refresh();
                    },
                    child: Text(
                      '편집',
                      style: TextStyle(
                        color: ColorPalette.blue,
                        fontSize: 16,
                      ),
                    ),
                  )
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                exhibitionItemCompleteTextWidget(),
                SizedBox(height: 40),
                Obx(() => !controller.isEditingItemList.value ?
                  exhibitionItemListWidget() : exhibitionItemEditWidget()),
                SizedBox(height: 40),
                Center(
                  child: Text(
                    '판매중인 작품 ${((controller.exhibitionItems.length / 2).ceil())}개 이상이어야 합니다.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.red,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                NextButton(
                  text: '완료',
                  value: controller.isValidItemSave(),
                  onTap: () {
                    // TODO: 작품 등록 저장하기
                    Get.until((route) => Get.currentRoute == Routes.SELLER_APP);
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
