import 'package:flutter/material.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/next_button.dart';

enum BottomSheetType { noneButton, oneButton, twoButton }

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    required this.title,
    required this.description,
    this.descriptionFontSize = 16,
    required this.height,
    required this.buttonType,
    required this.onCloseButtonPressed,
    this.leftButtonText,
    this.rightButtonText,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
  });

  final String title;
  final String description;
  final double descriptionFontSize;
  final double height;
  final BottomSheetType buttonType;
  final String? leftButtonText;
  final String? rightButtonText;
  final Function() onCloseButtonPressed;
  final Function()? onLeftButtonPressed;
  final Function()? onRightButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: const Color(0xff191f28),
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onCloseButtonPressed,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              description,
              style: TextStyle(
                color: Color(0xff191f28),
                fontWeight: FontWeight.w400,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: descriptionFontSize,
              ),
            ),
          ),
          if (buttonType == BottomSheetType.oneButton)
            NextButton(
              text: leftButtonText!,
              value: true,
              onTap: onLeftButtonPressed!,
            ),
          if (buttonType == BottomSheetType.twoButton)
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onLeftButtonPressed,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorPalette.grey_2,
                        ),
                        child: Text(
                          leftButtonText ?? '왼쪽 버튼',
                          style: TextStyle(
                            color: ColorPalette.grey_7,
                            fontWeight: FontWeight.bold,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: onRightButtonPressed,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorPalette.red,
                        ),
                        child: Text(
                          rightButtonText ?? '오른쪽 버튼',
                          style: TextStyle(
                            color: ColorPalette.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
