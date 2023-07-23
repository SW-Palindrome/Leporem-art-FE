import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leporemart/src/models/profile_edit.dart';
import 'package:leporemart/src/repositories/profile_edit_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class SellerProfileEditController extends GetxController {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<bool> isNicknameValid = false.obs;
  Rx<bool> isNicknameDuplicate = false.obs;
  Rx<bool> isNicknameFocused = false.obs;
  Rx<bool> isNicknameChanged = false.obs;
  Rx<File> profileImage = File('').obs;
  Rx<bool> isProfileImageChanged = false.obs;
  Rx<bool> isDescriptionChanged = false.obs;

  final ProfileEditRepository _profileEditRepository = ProfileEditRepository();
  SellerProfileEdit sellerProfileEdit = SellerProfileEdit(
    nickname: '불건전한 소환사명',
    profileImageUrl:
        'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
    description: '설명\n설명\n설명\n설명\n설명\n설명\n',
  );

  @override
  void onInit() async {
    await fetch();
    nicknameController.text = sellerProfileEdit.nickname ?? '';
    descriptionController.text = sellerProfileEdit.description ?? '';
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      sellerProfileEdit = await _profileEditRepository.fetchSellerProfileEdit();
    } catch (e) {
      // 에러 처리
      print('Error fetching seller profile edit: $e');
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

  void editProfile() async {}

  void setFocus(bool focused) {
    isNicknameFocused.value = focused;
  }
}
