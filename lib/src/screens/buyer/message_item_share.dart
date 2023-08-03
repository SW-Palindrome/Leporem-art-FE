import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

import '../../utils/currency_formatter.dart';

class MessageItemShare extends StatelessWidget {
  const MessageItemShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '홍준식님의 작품',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _searchField(),
                SizedBox(height: 16),
                _itemList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorPalette.grey_3,
        ),
        color: ColorPalette.grey_2,
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '작품명을 입력해주세요.',
            hintStyle: TextStyle(
              fontSize: 16,
              color: ColorPalette.grey_5,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  _itemList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _itemWidget();
      },
    );
  }

  _itemWidget() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg",
                height: Get.width * 0.23,
                width: Get.width * 0.23,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "홍준식",
                    style: TextStyle(
                      color: ColorPalette.grey_4,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "구름을 담은 컵",
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${CurrencyFormatter().numberToCurrency(10000)}원',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
