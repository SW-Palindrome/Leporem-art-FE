import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/controllers/seller_profile_controller.dart';
import 'package:leporemart/src/models/profile_edit.dart';
import 'package:leporemart/src/repositories/profile_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class SellerProfileEditController extends GetxController {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<bool> firstEdit = false.obs;
  Rx<bool> isNicknameValid = true.obs;
  Rx<bool> isNicknameDuplicate = false.obs;
  Rx<bool> isNicknameFocused = false.obs;
  Rx<bool> isNicknameChanged = false.obs;
  Rx<File> profileImage = File('').obs;
  Rx<bool> isProfileImageChanged = false.obs;
  Rx<bool> isDescriptionChanged = false.obs;

  SellerProfileEdit sellerProfileEdit = SellerProfileEdit(
    nickname: '',
    profileImageUrl: '',
    description: '',
  );

  @override
  void onInit() async {
    await fetch();
    nicknameController.text = sellerProfileEdit.nickname;
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      String nickname =
          Get.find<SellerProfileController>().sellerProfile.value.nickname;
      String profileImageUrl = Get.find<SellerProfileController>()
          .sellerProfile
          .value
          .profileImageUrl;
      String description =
          Get.find<SellerProfileController>().sellerProfile.value.description;
      sellerProfileEdit = SellerProfileEdit(
        nickname: nickname,
        profileImageUrl: profileImageUrl,
        description: description,
      );
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile edit: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  Future<void> selectImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
      isProfileImageChanged.value = true;
    }
  }

  void checkNickname(String value) {
    RegExp regExp = RegExp(r'^[\w가-힣_-]{2,10}$');
    isNicknameValid.value = regExp.hasMatch(value);
  }

  Future<void> isDuplicate(String value) async {
    try {
      final response =
          await DioSingleton.dio.post("/users/validate/nickname/$value");
      if (response.statusCode != 200) {
        isNicknameDuplicate.value = false;
      }
      isNicknameDuplicate.value = true;
    } catch (e) {
      isNicknameDuplicate.value = false;
    }
  }

  void checkNicknameChanged(String value) {
    if (value != sellerProfileEdit.nickname) {
      isNicknameChanged.value = true;
    } else {
      isNicknameChanged.value = false;
    }
  }

  void edit() async {
    try {
      if (isNicknameChanged.value) {
        try {
          final response = await DioSingleton.dio.patch("/users/nickname",
              data: {
                "nickname": nicknameController.text,
              },
              options: Options(
                headers: {
                  "Authorization":
                      "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
                },
              ));

          if (response.statusCode != 200) {
            throw Exception('Status code: ${response.statusCode}');
          }
        } catch (e) {
          throw ('Error editing nickname: $e');
        }
      }
      if (isProfileImageChanged.value) {
        try {
          final formData = FormData.fromMap({
            "profile_image": await MultipartFile.fromFile(
              profileImage.value.path,
              filename: profileImage.value.path.split('/').last,
            ),
          });
          final response = await DioSingleton.dio.patch("/users/profile-image",
              data: formData,
              options: Options(
                headers: {
                  "Authorization":
                      "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
                },
              ));

          if (response.statusCode != 200) {
            throw Exception('Status code: ${response.statusCode}');
          }
        } catch (e) {
          throw ('Error editing profile image: $e');
        }
      }
      Get.back();
      Get.snackbar('프로필 수정', '프로필이 수정되었습니다.');
      Get.find<SellerProfileController>().fetch();
    } catch (e) {
      print('Error editing profile: $e');
    }
  }

  void setFocus(bool focused) {
    isNicknameFocused.value = focused;
  }

  bool isEditable() {
    return isNicknameValid.value &&
        (isNicknameChanged.value || isProfileImageChanged.value);
  }
}
