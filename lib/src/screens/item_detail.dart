import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _itemThumbnail(),
              _itemTitle(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/heart.svg',
                  width: 30,
                  colorFilter:
                      ColorFilter.mode(ColorPalette.purple, BlendMode.srcIn),
                ),
                SizedBox(width: 10),
                Text(
                  "10,000원",
                  style: const TextStyle(
                    color: const Color(0xff191f28),
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _itemTitle() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorPalette.grey_2,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                "홍준식(준식이가준비한식사)",
                style: const TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "매너온도 추가",
                style: const TextStyle(
                  color: const Color(0xfff04452),
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "가로등 빛 받은 나뭇잎 컵",
                style: const TextStyle(
                  color: const Color(0xff191f28),
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "잔여 3점",
                style: const TextStyle(
                  color: const Color(0xff594bf8),
                  fontWeight: FontWeight.w400,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _categoryWidget('컵'),
              _categoryWidget('머그컵'),
            ],
          )
        ],
      ),
    );
  }

  Container _itemThumbnail() {
    return Container(
      height: Get.width,
      width: Get.width,
      color: Colors.red,
    );
  }

  Padding _categoryWidget(String category) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: ColorPalette.grey_3,
          ),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              color: Color(0xff191f28),
              fontWeight: FontWeight.w400,
              fontFamily: "PretendardVariable",
              fontStyle: FontStyle.normal,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );

    Container _itemBottomNavigationBar() {
      return Container(
        padding: EdgeInsets.only(right: 8.0),
      );
    }
  }
}
