import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/agreement_controller.dart';
import 'package:leporemart/src/screens/account_type.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/bottom_sheet.dart';
import 'package:leporemart/src/widgets/next_button.dart';

class Agreement extends GetView<AgreementController> {
  const Agreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
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
              Obx(
                () => Container(
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
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              agreeRow("공예쁨 이용약관 동의", true, 0),
              agreeRow("개인정보 수집 및 이용 동의", true, 1),
              agreeRow("마케팅 수신 동의", false, 2),
              Spacer(),
              Obx(
                () => NextButton(
                  text: "다음",
                  value: controller.isNextButtonEnabled,
                  onTap: () {
                    Get.to(AccountType());
                  },
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
        InkWell(
          onTap: () {
            Get.bottomSheet(
              MyBottomSheet(
                title: "개인정보 수집 및 이용 동의",
                description:
                    "공예쁨은 귀하의 개인정보를 중요시하며, 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』, 『개인정보 보호법』, 『통신비밀보호법』, 『전기통신사업법』 등 정보통신 서비스 제공자가 준수하여야 할 관련 법령상의 개인정보보호 규정을 준수하고 있습니다. 회사는 본 개인정보취급방침을 통하여 귀하가 회사에 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 회사가 개인정보보호를 위해 어떠한 조치룰 취하고 있는지 알려드립니다.\n\n회사의 개인정보취급방침은 정부정책, 관련 법령 및 회사 내부 방침 변경 등 사회적 필요와 변화에 따라 수시로 변경될 수 있고, 회사는 이에 따른 개인정보취급방침의 지속적인 개선을 위하여 필요한 절차를 정하고 있습니다. 개인정보취급방침을 개정하는 경우 회사는 그 개정사항을 홈페이지에 게시하여 귀하가 개정된 사항을 쉽게 확인할 수 있도록 하고 있습니다.",
                descriptionFontSize: 12.0,
                height: Get.height * 0.4,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
              ),
            );
          },
          child: Padding(
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
        ),
      ],
    );
  }
}
