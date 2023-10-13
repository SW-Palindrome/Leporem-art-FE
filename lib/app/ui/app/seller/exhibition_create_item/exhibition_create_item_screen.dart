import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/seller/exhibition_create_item/widgets/template_select_widget.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';

import '../../../theme/app_theme.dart';

class ExhibitionCreateItemScreen extends StatelessWidget {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 20),
              templateSelectWidget(),
              SizedBox(height: 40),
              //itemImageInputWidget(),
              SizedBox(height: 40),
              //itemAudioInputWidget(),
              SizedBox(height: 40),
              //itemSaleSelctWidget(),
              SizedBox(height: 40),
              //itemFlopInputWidget(),
              SizedBox(height: 40),
              //itemCategoryInputWidget(),
              SizedBox(height: 40),
              //itemTitleInputWidget(),
              SizedBox(height: 40),
              //itemDescriptionInputWidget(),
              SizedBox(height: 40),
              //itemSizeInputWidget(),
              SizedBox(height: 40),
              //itemPriceInputWidget(),
              SizedBox(height: 40),
              //itemAmountInputWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
