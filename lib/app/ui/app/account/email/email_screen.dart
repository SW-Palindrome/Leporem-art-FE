import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controller/account/email/email_controller.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../common/home/home.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';

class EmailScreen extends GetView<EmailController> {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () {
          Get.back();
          controller.reset();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
              Text(
                "인증을 위해 학교 이메일 주소를\n입력해주세요.",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: Get.height * 0.05),
              Obx(
                () => Visibility(
                  visible: controller.isSendClicked.value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Focus(
                      onFocusChange: (value) {
                        logAnalytics(
                            name: 'seller_signup',
                            parameters: {'action': 'code_form_focus'});
                      },
                      child: TextField(
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        onChanged: (text) {
                          controller.isCodeValidated(text);
                        },
                        controller: controller.codeController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          labelText: "인증 번호",
                          labelStyle: TextStyle(
                            color: controller.isCodeError.value
                                ? ColorPalette.red
                                : ColorPalette.grey_6,
                            fontSize: 11,
                          ),
                          hintText: "000000",
                          hintStyle: TextStyle(
                            color: ColorPalette.grey_3,
                            fontSize: 20,
                          ),
                          errorText: controller.isCodeError.value
                              ? "인증번호를 다시 확인해주세요."
                              : null,
                          errorStyle: TextStyle(
                            color: ColorPalette.red,
                            fontSize: 11,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: controller.isCodeError.value
                                  ? ColorPalette.red
                                  : ColorPalette.grey_3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette.purple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Focus(
                  onFocusChange: (focused) {
                    logAnalytics(
                        name: 'seller_signup',
                        parameters: {'action': 'email_form_focus'});
                    controller.setFocus(focused);
                    if (!focused) {
                      controller
                          .setDisplayError(!controller.isEmailValid.value);
                      print(controller.isDisplayError.value);
                    }
                  },
                  child: TextField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    enabled: !controller.isSendClicked.value,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: "이메일 주소",
                      labelStyle: TextStyle(
                        color: controller.isDisplayError.value
                            ? ColorPalette.red
                            : ColorPalette.grey_6,
                        fontSize: 12,
                      ),
                      hintText: "example@abc.ac.kr",
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_3,
                        fontSize: 20,
                      ),
                      errorText: controller.isDisplayError.value
                          ? "올바른 양식의 이메일 주소를 입력해주세요."
                          : null,
                      errorStyle: TextStyle(
                        color: ColorPalette.red,
                        fontSize: 11,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: controller.isDisplayError.value
                              ? ColorPalette.red
                              : ColorPalette.grey_3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorPalette.purple,
                        ),
                      ),
                    ),
                    onChanged: (text) {
                      controller.checkEmail(text);
                    },
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => controller.isSendClicked.value
                    ? NextButton(
                        text: "인증하기",
                        value: controller.isCodeValid.value,
                        onTap: () async {
                          logAnalytics(
                              name: 'seller_signup',
                              parameters: {'action': 'code_verify'});
                          await controller.checkCode();
                          if (controller.isCodeError.value == false) {
                            Get.bottomSheet(
                              MyBottomSheet(
                                title: "인증 성공",
                                description:
                                    "학교 메일 인증에 성공했습니다.\n공예쁨에서 상상의 나래를 펼쳐주세요!",
                                height: Get.height * 0.3,
                                buttonType: BottomSheetType.oneButton,
                                leftButtonText: "공예쁨 시작하기",
                                onCloseButtonPressed: () {
                                  Get.offAll(HomeScreen(isLoginProceed: true));
                                },
                                onLeftButtonPressed: () {
                                  Get.offAll(HomeScreen(isLoginProceed: true));
                                },
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.0),
                                ),
                              ),
                              isDismissible: false,
                            );
                          }
                        },
                      )
                    : NextButton(
                        text: "인증메일 전송하기",
                        value: !controller.isDisplayError.value &&
                            controller.isEmailValid.value,
                        onTap: () {
                          logAnalytics(
                              name: 'seller_signup',
                              parameters: {'action': 'email_send'});
                          controller.sendEmail();
                          controller.setSendClicked(true);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
