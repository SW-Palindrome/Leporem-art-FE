import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';
import '../exhibition_create_seller/widgets/template_select_widget.dart';
import 'widgets/item_amount_input_widget.dart';
import 'widgets/item_category_input_widget.dart';
import 'widgets/item_description_input_widget.dart';
import 'widgets/item_flop_input_widget.dart';
import 'widgets/item_image_input_widget.dart';
import 'widgets/item_price_input_widget.dart';
import 'widgets/item_sale_select_widget.dart';
import 'widgets/item_size_input_widget.dart';
import 'widgets/item_title_input_widget.dart';

class ExhibitionCreateItemScreen extends GetView<ExhibitionController> {
  const ExhibitionCreateItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        isWhite: true,
        title: '작품 등록',
        onTapLeadingIcon: () {
          Get.back();
        },
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                print('미리보기');
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
          child: Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  templateSelectWidget(),
                  SizedBox(height: 40),
                  itemImageInputWidget(),
                  SizedBox(height: 40),
                  //itemAudioInputWidget(),
                  SizedBox(height: 40),
                  itemSaleSelectWidget(),
                  if (controller.isItemSailEnabled.value == true)
                    _itemSaleWidgets()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_itemSaleWidgets() {
  return Column(
    children: [
      SizedBox(height: 40),
      itemFlopInputWidget(),
      SizedBox(height: 40),
      itemCategoryInputWidget(),
      SizedBox(height: 40),
      itemTitleInputWidget(),
      SizedBox(height: 40),
      itemDescriptionInputWidget(),
      SizedBox(height: 40),
      itemSizeInputWidget(),
      SizedBox(height: 40),
      itemPriceInputWidget(),
      SizedBox(height: 40),
      itemAmountInputWidget(),
    ],
  );
}
