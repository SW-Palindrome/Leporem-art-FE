import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "인기 상품 둘러보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff191f28),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "더보기",
                        style: TextStyle(
                          color: Color(0xff594BF8),
                          fontSize: 14,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/next.svg',
                        height: 16,
                        width: 16,
                        color: Color(0xff594BF8),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExtendedImage.network(
                      'https://image.idus.com/image/files/9fde7b8f5ae443188843ceef0678df41_320.jpg',
                      cache: true,
                      width: 153,
                      height: 153,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '홍준식',
                    style: TextStyle(
                      color: Color(0xffadb3be),
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '가로등 빛 받은 나뭇잎 컵',
                    style: TextStyle(
                      color: Color(0xff191F28),
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '10,000원',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff191F28),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
