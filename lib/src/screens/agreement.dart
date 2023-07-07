import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/agreement_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class Agreement extends GetView<AgreementController> {
  const Agreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.15),
              Text(
                "개인정보 약관 동의 후\n서비스를 이용할 수 있어요.",
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: Get.height * 0.05),
              Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: controller.allAgreed.value
                            ? ColorPalette.purple
                            : ColorPalette.grey_3,
                      ),
                      color: controller.allAgreed.value
                          ? ColorPalette.purple.withAlpha(10)
                          : ColorPalette.white,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(12),
                          constraints: BoxConstraints(),
                          onPressed: () {
                            controller.toggleAllAgreed();
                          },
                          icon: SvgPicture.asset(
                            controller.allAgreed.value
                                ? 'assets/icons/checkbox_select.svg'
                                : 'assets/icons/checkbox_unselect.svg',
                            width: 24,
                          ),
                        ),
                        Text(
                          "모두 동의합니다.",
                          style: TextStyle(
                            color: Color(0xff515A68),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: Get.height * 0.01),
              agreeRow("공예쁨 이용약관 동의", true, 0),
              agreeRow("개인정보 수집 및 이용 동의", true, 1),
              agreeRow("마케팅 수신 동의", false, 2),
              Spacer(),
              Obx(
                () => InkWell(
                  onTap: controller.isNextButtonEnabled
                      ? () {
                          // 다음 페이지로 이동하는 로직 추가
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: Get.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: controller.isNextButtonEnabled
                          ? ColorPalette.purple
                          : ColorPalette.grey_3,
                    ),
                    child: Center(
                      child: Text(
                        "다음",
                        style: TextStyle(
                          color: controller.isNextButtonEnabled
                              ? ColorPalette.white
                              : ColorPalette.grey_4,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row agreeRow(String text, bool isRequired, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => IconButton(
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(),
              onPressed: () {
                controller.toggleAgreed(index);
              },
              icon: SvgPicture.asset(
                controller.agreedList[index]
                    ? 'assets/icons/checkbox_select.svg'
                    : 'assets/icons/checkbox_unselect.svg',
                width: 24,
              ),
            )),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: TextStyle(
                  color: controller.agreedList[index]
                      ? Color(0xff191f28)
                      : Color(0xff515a68),
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
                text: text,
              ),
              TextSpan(
                style: TextStyle(
                  color: ColorPalette.purple,
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
                text: isRequired ? "(필수)" : "(선택)",
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: RichText(
            text: TextSpan(
              text: '보기',
              style: TextStyle(
                color: Color(0xffadb3be),
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
