import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

startInquiryWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Text(
      '기획전을 등록할까요?',
      style: TextStyle(
        color: ColorPalette.black,
        fontFamily: FontPalette.pretendard,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}
