import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../../utils/currency_formatter.dart';
import '../../../../theme/app_theme.dart';

itemPriceInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '가격을 알려주세요.',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
            Text(
              '(1,000~1,000,000원)',
              style: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorPalette.grey_4,
              width: 1,
            ),
          ),
        ),
        child: TextField(
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          keyboardType: TextInputType.number,
          controller: controller.itemPriceController,
          maxLength: 9,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9,]+$')),
            CurrencyFormatter(), // 사용자 정의 CurrencyFormatter 적용
          ],
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            suffix: Text(
              '원',
              style: TextStyle(
                color: Colors.black,
                fontFamily: FontPalette.pretendard,
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
            hintText: '판매가 입력',
            hintStyle: TextStyle(
              color: ColorPalette.grey_4,
              fontWeight: FontWeight.w600,
              fontFamily: FontPalette.pretendard,
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ],
  );
}
