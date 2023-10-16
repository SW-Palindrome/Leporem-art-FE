import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../controller/seller/exhibition/exhibition_controller.dart';
import '../../../../theme/app_theme.dart';

itemSizeInputWidget() {
  final controller = Get.find<ExhibitionController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Text(
              '작품의 크기를 알려주세요.',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
              ),
            ),
            Text(
              '(선택)',
              style: TextStyle(
                color: ColorPalette.grey_4,
                fontWeight: FontWeight.w600,
                fontFamily: FontPalette.pretendard,
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '가로',
                  style: TextStyle(
                    color: ColorPalette.grey_4,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontPalette.pretendard,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorPalette.grey_4,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: controller.itemWidthController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$'))
                    ],
                    onChanged: (value) {
                      // 입력값을 제한하기 위해 정수 부분과 소수 부분을 분리합니다.
                      String integerPart = '';
                      String decimalPart = '';

                      if (value.isNotEmpty) {
                        // 입력값이 비어있지 않은 경우, '.' 기준으로 정수 부분과 소수 부분으로 분리합니다.
                        if (value.contains('.')) {
                          List<String> parts = value.split('.');
                          integerPart = parts[0];
                          if (parts.length > 1) {
                            decimalPart = parts[1];
                          }
                        } else {
                          integerPart = value;
                        }
                      }

                      // 정수 부분을 1~4글자로 제한합니다.
                      if (integerPart.length > 4) {
                        integerPart = integerPart.substring(0, 4);
                      }

                      // 소수 부분을 0~2글자로 제한합니다.
                      if (decimalPart.length > 2) {
                        decimalPart = decimalPart.substring(0, 2);
                      }

                      // 새로운 입력 값을 생성합니다.
                      String newValue = integerPart;
                      if (value.contains('.')) {
                        newValue += '.$decimalPart';

                        // 새로운 입력 값을 TextField에 설정합니다.
                        if (value != newValue) {
                          controller.itemWidthController.value =
                              TextEditingValue(
                            text: newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: newValue.length),
                            ),
                          );
                        }
                      } else {
                        controller.itemWidthController.value = TextEditingValue(
                          text: newValue,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: newValue.length),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_4,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                      suffixText: 'cm',
                      suffixStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '세로',
                  style: TextStyle(
                    color: ColorPalette.grey_4,
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorPalette.grey_4,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.itemDepthController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$'))
                    ],
                    onChanged: (value) {
                      // 입력값을 제한하기 위해 정수 부분과 소수 부분을 분리합니다.
                      String integerPart = '';
                      String decimalPart = '';

                      if (value.isNotEmpty) {
                        // 입력값이 비어있지 않은 경우, '.' 기준으로 정수 부분과 소수 부분으로 분리합니다.
                        if (value.contains('.')) {
                          List<String> parts = value.split('.');
                          integerPart = parts[0];
                          if (parts.length > 1) {
                            decimalPart = parts[1];
                          }
                        } else {
                          integerPart = value;
                        }
                      }

                      // 정수 부분을 1~4글자로 제한합니다.
                      if (integerPart.length > 4) {
                        integerPart = integerPart.substring(0, 4);
                      }

                      // 소수 부분을 0~2글자로 제한합니다.
                      if (decimalPart.length > 2) {
                        decimalPart = decimalPart.substring(0, 2);
                      }

                      // 새로운 입력 값을 생성합니다.
                      String newValue = integerPart;
                      if (value.contains('.')) {
                        newValue += '.$decimalPart';

                        // 새로운 입력 값을 TextField에 설정합니다.
                        if (value != newValue) {
                          controller.itemDepthController.value =
                              TextEditingValue(
                            text: newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: newValue.length),
                            ),
                          );
                        }
                      } else {
                        controller.itemDepthController.value = TextEditingValue(
                          text: newValue,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: newValue.length),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_4,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                      suffixText: 'cm',
                      suffixStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '높이',
                  style: TextStyle(
                    color: ColorPalette.grey_4,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontPalette.pretendard,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorPalette.grey_4,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.itemHeightController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$'))
                    ],
                    onChanged: (value) {
                      // 입력값을 제한하기 위해 정수 부분과 소수 부분을 분리합니다.
                      String integerPart = '';
                      String decimalPart = '';

                      if (value.isNotEmpty) {
                        // 입력값이 비어있지 않은 경우, '.' 기준으로 정수 부분과 소수 부분으로 분리합니다.
                        if (value.contains('.')) {
                          List<String> parts = value.split('.');
                          integerPart = parts[0];
                          if (parts.length > 1) {
                            decimalPart = parts[1];
                          }
                        } else {
                          integerPart = value;
                        }
                      }

                      // 정수 부분을 1~4글자로 제한합니다.
                      if (integerPart.length > 4) {
                        integerPart = integerPart.substring(0, 4);
                      }

                      // 소수 부분을 0~2글자로 제한합니다.
                      if (decimalPart.length > 2) {
                        decimalPart = decimalPart.substring(0, 2);
                      }

                      // 새로운 입력 값을 생성합니다.
                      String newValue = integerPart;
                      if (value.contains('.')) {
                        newValue += '.$decimalPart';

                        // 새로운 입력 값을 TextField에 설정합니다.
                        if (value != newValue) {
                          controller.itemHeightController.value =
                              TextEditingValue(
                            text: newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: newValue.length),
                            ),
                          );
                        }
                      } else {
                        controller.itemHeightController.value =
                            TextEditingValue(
                          text: newValue,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: newValue.length),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_4,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                      suffixText: 'cm',
                      suffixStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontPalette.pretendard,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
