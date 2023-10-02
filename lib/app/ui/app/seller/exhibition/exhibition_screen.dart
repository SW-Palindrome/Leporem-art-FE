import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class ExhibitionScreen extends StatelessWidget {
  const ExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기획전',
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: FontPalette.pretenderd,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _exhibitionListWidget();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 24);
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }

  _emptyExhibitionWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 144),
          Image.asset(
            'assets/images/rabbit.png',
            height: 200,
          ),
          SizedBox(height: 24),
          Text(
            '아직 등록된 기획전이 없어요.',
            style: TextStyle(
              fontSize: 16,
              color: ColorPalette.grey_5,
              fontFamily: FontPalette.pretenderd,
            ),
          ),
        ],
      ),
    );
  }

  _exhibitionListWidget() {
    return Column(
      children: [
        _exhibitionWidget(
            '한가위 아름다운 단풍 기획전',
            'http://www.knnews.co.kr/edb/nimages/2022/04/2022040416024296883.jpg',
            '우유병 도예 작가',
            '2023.10.24 ~ 10.31'),
      ],
    );
  }

  _exhibitionWidget(
      String title, String imageUrl, String artist, String period) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorPalette.white,
                  fontFamily: FontPalette.pretenderd,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    artist,
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 1,
                    height: 12,
                    color: ColorPalette.white.withOpacity(0.4),
                  ),
                  SizedBox(width: 12),
                  Text(
                    period,
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontFamily: FontPalette.pretenderd,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
