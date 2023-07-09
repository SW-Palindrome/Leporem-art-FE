import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/widgets/next_button.dart';

enum BottomSheetType { noneButton, oneButton, twoButton }

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    Key? key,
    required this.title,
    required this.description,
    this.descriptionFontSize = 16,
    required this.height,
    required this.buttonType,
    this.leftButtonText,
    this.rightButtonText,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
  }) : super(key: key);

  final String title;
  final String description;
  final double descriptionFontSize;
  final double height;
  final BottomSheetType buttonType;
  final String? leftButtonText;
  final String? rightButtonText;
  final Function()? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;

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
                  onPressed: () {
                    Get.back(); // bottomSheet 닫기
                  },
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: onLeftButtonPressed,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200],
                      ),
                      child: Text(
                        '왼쪽 버튼',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: onRightButtonPressed,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text(
                        '오른쪽 버튼',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
