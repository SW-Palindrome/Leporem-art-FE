import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

class RecentItemScreen extends StatelessWidget {
  const RecentItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '최근 본 상품',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _deleteButton(),
                SizedBox(height: 14),
                _recentItemList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _deleteButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorPalette.grey_3,
      ),
      child: Text(
        '전체 삭제',
        style: TextStyle(
          color: ColorPalette.grey_7,
          fontWeight: FontWeight.w500,
          fontFamily: "PretendardVariable",
          fontStyle: FontStyle.normal,
          fontSize: 11.0,
        ),
      ),
    );
  }

  _recentItemList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _recentItem();
      },
    );
  }

  _recentItem() {
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
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '테스트',
                        style: TextStyle(
                          color: ColorPalette.grey_4,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '삭제',
                        style: TextStyle(
                          color: ColorPalette.grey_4,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '제목',
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/message_outline.svg',
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/icons/heart_outline.svg',
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4, BlendMode.srcIn),
                      ),
                    ],
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
