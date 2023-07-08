import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.text,
    required this.value,
    required this.onTap,
  });

  final String text;
  final bool value;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: value ? onTap : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: Get.width,
        height: 48,
        decoration: value
            ? ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.00, -0.07),
                  end: Alignment(-1, 0.07),
                  colors: [Color(0xFF594BF8), Color(0xFF9C00E6)],
                ),
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
