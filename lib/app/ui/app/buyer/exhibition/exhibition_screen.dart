import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class BuyerExhibitionScreen extends StatelessWidget {
  const BuyerExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            '기획전',
            style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontSize: 24),
          ),
        ],
      ),
    );
  }
}
