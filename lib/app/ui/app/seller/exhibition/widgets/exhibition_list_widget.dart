import 'package:flutter/material.dart';

import 'exhibition_widget.dart';

exhibitionListWidget(String title, String imageUrl, String seller,
    String startDate, String endDate, int exhibitionId) {
  return Column(
    children: [
      exhibitionWidget(
        title: title,
        imageUrl: imageUrl,
        seller: seller,
        period: '$startDate ~ $endDate',
        exhibitionId: exhibitionId,
      ),
    ],
  );
}
