import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import 'single_gesture_detector.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.text,
    required this.value,
    required this.onTap,
    this.width = double.infinity,
  });

  final String text;
  final bool value;
  final Function() onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SingleGestureDetector(
      onTap: value ? onTap : () {},
      child: Container(
        width: width,
        height: Get.height * 0.06,
        decoration: value
            ? ShapeDecoration(
                gradient: ColorPalette.gradientPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorPalette.grey_3,
              ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: value ? ColorPalette.white : ColorPalette.grey_4,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
