import 'package:flutter/material.dart';

import 'exhibition_widget.dart';

exhibitionListWidget() {
  return Column(
    children: [
      exhibitionWidget(
          title: '한가위 아름다운 단풍 기획전',
          imageUrl:
              'http://www.knnews.co.kr/edb/nimages/2022/04/2022040416024296883.jpg',
          seller: '우유병 도예 작가',
          period: '2023.10.24 ~ 10.31'),
    ],
  );
}
