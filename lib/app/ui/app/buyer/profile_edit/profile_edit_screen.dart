import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/buyer/profile_edit/buyer_profile_edit_controller.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';

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
                          name: 'buyer_profile_edit',
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              _imageEdit(),
              SizedBox(height: 30),
              _nicknameEdit(),
              Spacer(),
              _withdrawalText(context),
            ],
          ),
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
                  name: 'buyer_profile_edit',
                  parameters: {'action': 'nickname_form_focus'});
              controller.setFocus(focused);
              if (!focused) {
                controller.checkNickname(controller.nicknameController.text);
                controller.firstEdit.value = true;
              }
            },
            child: TextField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
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
                : CachedNetworkImage(
                    imageUrl: controller.buyerProfileEdit.profileImage,
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
                  name: 'buyer_profile_edit',
                  parameters: {'action': 'edit_image'});
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

  _withdrawalText(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('회원 탈퇴를 하시겠습니까?'),
                content: const Text(
                    '계정을 삭제하면 게시글, 좋아요, 채팅 등 모든 활동 정보가 삭제되고 다시 복구할 수 없습니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('취소'),
                  ),
                  TextButton(
                      onPressed: () async {
                        await controller.inactive();
                      },
                      child: const Text('확인',
                          style: TextStyle(color: ColorPalette.red))),
                ],
              );
            });
      },
      child: Text(
        '회원 탈퇴',
        style: TextStyle(
          color: ColorPalette.red,
          fontFamily: FontPalette.pretendard,
          fontSize: 12,
        ),
      ),
    );
  }
}
