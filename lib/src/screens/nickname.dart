import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/nickname_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class Nickname extends GetView<NicknameController> {
  const Nickname({super.key});

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
                  controller.setFocus(focused);
                  if (!focused) {
                    controller
                        .setDisplayError(!controller.isNicknameValid.value);
                  }
                },
                child: Obx(
                  () => TextFormField(
                    controller: controller.nicknameController,
                    keyboardType: TextInputType.emailAddress,
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
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
