import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              _filterDropDown('최신순'),
              SizedBox(width: 10),
              _filterDropDown('작품 종류'),
              SizedBox(width: 10),
              _filterDropDown('가격대'),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 15.0),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "인기 상품 둘러보기",
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w600,
          //           color: ColorPalette.black,
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {},
          //         child: Row(
          //           children: [
          //             Text(
          //               "더보기",
          //               style: TextStyle(
          //                 color: ColorPalette.purple,
          //                 fontSize: 14,
          //               ),
          //             ),
          //             SvgPicture.asset(
          //               'assets/icons/arrow_right.svg',
          //               height: 16,
          //               width: 16,
          //               color: ColorPalette.purple,
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                childAspectRatio: 0.6,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => _itemWidget(
                'https://image.idus.com/image/files/9fde7b8f5ae443188843ceef0678df41_320.jpg',
                '홍준식',
                '가로등 빛 받은 나뭇잎 컵',
                10000,
                true,
                100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _itemWidget(String imageUrl, String name, String title, int price,
      bool isLiked, int heartCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ExtendedImage.network(
                imageUrl,
                cache: true,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: isLiked
                  ? SvgPicture.asset(
                      'assets/icons/heart.svg',
                      height: 24,
                      width: 24,
                      color: ColorPalette.red,
                    )
                  : SvgPicture.asset(
                      'assets/icons/heart.svg',
                      height: 24,
                      width: 24,
                      color: ColorPalette.grey_4,
                    ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            color: ColorPalette.grey_4,
            fontSize: 10,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: ColorPalette.black,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '$price원',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorPalette.black,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/heart.svg',
              height: 12,
              width: 12,
              color: ColorPalette.grey_4,
            ),
            Text(
              '$heartCount',
              style: TextStyle(
                color: ColorPalette.grey_5,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _filterDropDown(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffe6e7ec)),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 12)),
          SizedBox(width: 5),
          SvgPicture.asset(
            'assets/icons/arrow_down.svg',
            height: 10,
            width: 10,
            color: ColorPalette.grey_4,
          ),
        ],
      ),
    );
  }
}
