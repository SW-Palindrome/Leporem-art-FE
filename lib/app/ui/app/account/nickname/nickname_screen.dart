import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/login_config.dart';
import '../../../../controller/account/nickname/nickname_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/next_button.dart';

class NicknameScreen extends GetView<NicknameController> {
  const NicknameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        onTapLeadingIcon: () => Get.back(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
              Text(
                "가입하실 닉네임을 입력해주세요.",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: Get.height * 0.05),
              Focus(
                onFocusChange: (focused) {
                  logAnalytics(
                      name: 'signup',
                      parameters: {'action': 'nickname_form_focus'});
                  controller.setFocus(focused);
                  if (!focused) {
                    controller
                        .setDisplayError(!controller.isNicknameValid.value);
                  }
                },
                child: Obx(
                  () => TextFormField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: controller.nicknameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: "닉네임",
                      labelStyle: TextStyle(
                        color: controller.isDisplayError.value
                            ? ColorPalette.red
                            : ColorPalette.grey_6,
                        fontSize: 12,
                      ),
                      hintText: "한글, 영어, 숫자 _, - 2~10자 이내",
                      hintStyle: TextStyle(
                        color: ColorPalette.grey_3,
                        fontSize: 20,
                      ),
                      errorText: controller.isDisplayError.value
                          ? "올바른 양식의 닉네임을 입력해주세요."
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
                      controller.checkNickname(text);
                    },
                    onFieldSubmitted: (text) {
                      logAnalytics(name: 'signup', parameters: {
                        'step': 'agreement',
                        'action': 'nickname_submit: $text'
                      });
                    },
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => NextButton(
                  text: "인증하기",
                  value: !controller.isDisplayError.value &&
                      controller.isNicknameValid.value,
                  onTap: () async {
                    bool isDuplicate = await controller
                        .isDuplicate(controller.nicknameController.text);
                    late bool isSignupSuccessed;
                    switch (controller.loginPlatform) {
                      case LoginPlatform.kakao:
                        isSignupSuccessed = await controller.signupWithKakao();
                        break;
                      case LoginPlatform.naver:
                        break;
                      case LoginPlatform.apple:
                        isSignupSuccessed = await controller.signupWithApple();
                        break;
                      case LoginPlatform.none:
                        break;
                    }
                    if (!isDuplicate) {
                      if (isSignupSuccessed) {
                        Get.bottomSheet(
                          MyBottomSheet(
                            title: "계정 생성 완료",
                            description:
                                "계정 생성이 거의 마무리 되었습니다.\n계정의 종류를 선택해주세요.",
                            height: Get.height * 0.3,
                            buttonType: BottomSheetType.oneButton,
                            leftButtonText: "계정종류 선택하기",
                            onCloseButtonPressed: () {
                              logAnalytics(name: 'signup', parameters: {
                                'step': 'nickname',
                                'action': 'next_button'
                              });
                              Get.toNamed(Routes.ACCOUNT_TYPE);
                            },
                            onLeftButtonPressed: () {
                              logAnalytics(name: 'signup', parameters: {
                                'step': 'nickname',
                                'action': 'next_button'
                              });
                              Get.toNamed(Routes.ACCOUNT_TYPE);
                            },
                          ),
                          enableDrag: false,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.0),
                            ),
                          ),
                          isDismissible: false,
                        );
                      }
                    } else {
                      Get.bottomSheet(
                        MyBottomSheet(
                          title: "닉네임 중복",
                          description: "이미 사용중인 닉네임입니다.\n다른 닉네임을 입력해주세요.",
                          height: Get.height * 0.2,
                          buttonType: BottomSheetType.noneButton,
                          onCloseButtonPressed: () {
                            Get.back();
                          },
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.0),
                          ),
                        ),
                      );
                    }
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
