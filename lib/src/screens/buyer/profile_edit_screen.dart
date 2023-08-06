import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_profile_edit_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/utils/log_analytics.dart';

class BuyerProfileEditScreen extends GetView<BuyerProfileEditController> {
  const BuyerProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
            ),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          '프로필 수정',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorPalette.black,
          ),
        ),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: controller.isEditable()
                  ? () {
                      logAnalytics(
                          name: 'buyer-profile-edit',
                          parameters: {'action': 'complete'});
                      controller.edit();
                    }
                  : null,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: controller.isEditable()
                          ? ColorPalette.purple
                          : ColorPalette.purple.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            _imageEdit(),
            SizedBox(height: 30),
            _nicknameEdit(),
          ],
        ),
      ),
    );
  }

  _nicknameEdit() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '닉네임',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w500,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
            Spacer()
          ],
        ),
        SizedBox(height: 10),
        Obx(
          () => Focus(
            onFocusChange: (focused) {
              logAnalytics(
                  name: 'buyer-profile-edit',
                  parameters: {'action': 'nickname-form-focus'});
              controller.setFocus(focused);
              if (!focused) {
                controller.checkNickname(controller.nicknameController.text);
                controller.firstEdit.value = true;
              }
            },
            child: TextFormField(
              controller: controller.nicknameController,
              maxLength: 10,
              style: TextStyle(
                color: ColorPalette.black,
                fontSize: 18,
                height: 1,
              ),
              decoration: InputDecoration(
                counterText: "",
                hintText: "한글, 영어, 숫자 _, - 2~10자 이내",
                hintStyle: TextStyle(
                  color: ColorPalette.grey_3,
                  fontSize: 18,
                ),
                errorText: !controller.isNicknameValid.value &&
                        controller.firstEdit.value
                    ? "올바른 양식의 닉네임을 입력해주세요."
                    : null,
                errorStyle: TextStyle(
                  color: ColorPalette.red,
                  fontSize: 11,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorPalette.grey_4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorPalette.purple,
                  ),
                ),
              ),
              onChanged: (value) {
                controller.checkNicknameChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  _imageEdit() {
    return Stack(
      children: [
        Obx(
          () => ClipRRect(
            borderRadius: BorderRadius.circular(Get.width * 0.15),
            child: controller.isProfileImageChanged.value
                ? Image(
                    image: FileImage(controller.profileImage.value),
                    width: Get.width * 0.3,
                    height: Get.width * 0.3,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    controller.buyerProfileEdit.profileImage,
                    width: Get.width * 0.3,
                    height: Get.width * 0.3,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              logAnalytics(
                  name: 'buyer-profile-edit',
                  parameters: {'action': 'edit-image'});
              controller.selectImage();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorPalette.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorPalette.grey_2,
                  width: 1,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    ColorPalette.grey_5,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
