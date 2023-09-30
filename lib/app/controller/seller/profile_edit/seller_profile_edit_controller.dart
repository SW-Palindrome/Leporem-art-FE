import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/profile_edit.dart';
import '../../../data/repositories/nickname_repository.dart';
import '../../../data/repositories/profile_repository.dart';
import '../profile/seller_profile_controller.dart';

class SellerProfileEditController extends GetxController {
  final NicknameRepository nicknameRepository;
  final ProfileRepository profileRepository;

  SellerProfileEditController(
      {required this.nicknameRepository, required this.profileRepository})
      : assert(nicknameRepository != null && profileRepository != null);

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
    profileImage: '',
    description: '',
  );

  @override
  void onInit() async {
    await fetch();
    nicknameController.text = sellerProfileEdit.nickname;
    descriptionController.text = sellerProfileEdit.description;
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      String nickname =
          Get.find<SellerProfileController>().sellerProfile.value.nickname;
      String profileImageUrl =
          Get.find<SellerProfileController>().sellerProfile.value.profileImage;
      String description =
          Get.find<SellerProfileController>().sellerProfile.value.description;
      sellerProfileEdit = SellerProfileEdit(
        nickname: nickname,
        profileImage: profileImageUrl,
        description: description,
      );
    } catch (e) {
      // 에러 처리
      Logger logger = Logger(printer: PrettyPrinter());
      logger.e('Error fetching buyer profile edit: $e');
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

  Future<void> isDuplicate(String nickname) async {
    isNicknameDuplicate.value = await nicknameRepository.isDuplicate(nickname);
  }

  void checkNicknameChanged(String value) {
    if (value != sellerProfileEdit.nickname) {
      isNicknameChanged.value = true;
    } else {
      isNicknameChanged.value = false;
    }
  }

  void checkDescriptionChanged(String value) {
    if (value != sellerProfileEdit.description) {
      isDescriptionChanged.value = true;
    } else {
      isDescriptionChanged.value = false;
    }
  }

  void edit() async {
    profileRepository.editSellerProfile(
        isNicknameChanged.value,
        isProfileImageChanged.value,
        isDescriptionChanged.value,
        nicknameController.text,
        profileImage.value,
        descriptionController.text);
  }

  void setFocus(bool focused) {
    isNicknameFocused.value = focused;
  }

  bool isEditable() {
    return isNicknameValid.value &&
        (isNicknameChanged.value ||
            isProfileImageChanged.value ||
            isDescriptionChanged.value);
  }
}
