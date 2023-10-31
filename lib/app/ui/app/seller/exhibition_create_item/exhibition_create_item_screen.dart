import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/seller/exhibition_create_item/widgets/preview_bottomsheet_widget.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';
import 'widgets/item_amount_input_widget.dart';
import 'widgets/item_audio_input_widget.dart';
import 'widgets/item_description_input_widget.dart';
import 'widgets/item_edit_widget.dart';
import 'widgets/item_flop_input_widget.dart';
import 'widgets/item_image_input_widget.dart';
import 'widgets/item_price_input_widget.dart';
import 'widgets/item_sale_select_widget.dart';
import 'widgets/item_title_input_widget.dart';
import 'widgets/template_select_widget.dart';

class ExhibitionCreateItemScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorPalette.white,
        appBar: MyAppBar(
          appBarType: AppBarType.backAppBar,
          isWhite: true,
          title: '작품 등록',
          onTapLeadingIcon: () {
            Get.back();
          },
          actions: [
            if (controller.isItemTemplateUsed.value == false)
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      previewBottomSheetWidget(),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 18.5),
                    child: Text(
                      '미리보기',
                      style: TextStyle(
                        color: ColorPalette.purple,
                        fontFamily: FontPalette.pretendard,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: templateSelectWidget(),
                ),
                if (controller.isItemTemplateUsed.value == true)
                  _templateUseWidget(),
                if (controller.isItemTemplateUsed.value == false)
                  _templateNotUseWidget(),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: itemAudioInputWidget(),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: itemSaleSelectWidget(),
                ),
                if (controller.isItemSailEnabled.value == true)
                  _itemSaleWidgets(),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: NextButton(
                    onTap: () async {
                      if (controller.isItemTemplateUsed.value == true) {
                        Get.toNamed(
                          Routes.SELLER_EXHIBITION_CREATE_ITEM_TEMPLATE,
                          arguments: {
                            'exhibition_id': Get.arguments['exhibition_id'],
                            'item_id': Get.arguments['item_id'],
                          },
                        );
                      } else {
                        if (controller.isEditingItem.value == true) {
                          await controller.editExhibitionItemById(
                              Get.arguments['exhibition_id'],
                              Get.arguments['item_id']);
                        } else {
                          await controller.createExhibitionItemById(
                              Get.arguments['exhibition_id']);
                        }
                      }
                    },
                    text: controller.isItemTemplateUsed.value == true
                        ? '다음'
                        : '저장하기',
                    value: controller.isValidItemNext(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_templateUseWidget() {
  return Column(
    children: [
      SizedBox(height: 40),
      itemEditWidget(),
    ],
  );
}

_templateNotUseWidget() {
  return Column(
    children: [
      SizedBox(height: 40),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: itemImageInputWidget(),
      ),
    ],
  );
}

_itemSaleWidgets() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        SizedBox(height: 40),
        itemFlopInputWidget(),
        if (controller.isItemTemplateUsed.value == false) SizedBox(height: 40),
        if (controller.isItemTemplateUsed.value == false)
          itemTitleInputWidget(),
        if (controller.isItemTemplateUsed.value == false) SizedBox(height: 40),
        if (controller.isItemTemplateUsed.value == false)
          itemDescriptionInputWidget(),
        SizedBox(height: 40),
        itemPriceInputWidget(),
        SizedBox(height: 40),
        itemAmountInputWidget(),
      ],
    ),
  );
}
