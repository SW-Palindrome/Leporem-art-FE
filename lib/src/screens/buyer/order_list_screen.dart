import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/currency_formatter.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

class BuyerOrderListScreen extends StatelessWidget {
  const BuyerOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '주문 내역',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: _orderList(),
          ),
        ),
      ),
    );
  }

  _orderList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _orderItem();
      },
    );
  }

  _orderItem() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '주문일자 2023/06/07',
                            style: TextStyle(
                              color: ColorPalette.grey_4,
                              fontWeight: FontWeight.bold,
                              fontFamily: "PretendardVariable",
                              fontStyle: FontStyle.normal,
                              fontSize: 10,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorPalette.grey_3,
                            ),
                            child: Text(
                              '주문 취소',
                              style: TextStyle(
                                color: ColorPalette.red,
                                fontWeight: FontWeight.bold,
                                fontFamily: "PretendardVariable",
                                fontStyle: FontStyle.normal,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '제목',
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
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
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorPalette.grey_1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '배송 준비 중',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 11,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 31.5,
                    height: 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: ColorPalette.grey_3),
                  ),
                  Text(
                    '배송 중',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 11,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 31.5,
                    height: 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: ColorPalette.grey_3),
                  ),
                  Text(
                    '배송 완료',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 11,
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
