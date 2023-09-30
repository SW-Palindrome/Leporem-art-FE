import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:leporemart/app/controller/account/nickname/nickname_controller.dart';
import 'package:leporemart/app/controller/buyer/profile/buyer_profile_controller.dart';
import 'package:leporemart/app/data/repositories/nickname_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/profile_edit.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../utils/log_analytics.dart';

class BuyerProfileEditController extends GetxController {
  final NicknameRepository nicknameRepository;
  final ProfileRepository profileRepository;
  BuyerProfileEditController(
      {required this.nicknameRepository, required this.profileRepository})
      : assert(nicknameRepository != null && profileRepository != null);

  TextEditingController nicknameController = TextEditingController();

  Rx<bool> firstEdit = false.obs;
  Rx<bool> isNicknameValid = true.obs;
  Rx<bool> isNicknameDuplicate = false.obs;
  Rx<bool> isNicknameFocused = false.obs;
  Rx<bool> isNicknameChanged = false.obs;
  Rx<File> profileImage = File('').obs;
  Rx<bool> isProfileImageChanged = false.obs;

  BuyerProfileEdit buyerProfileEdit = BuyerProfileEdit(
    nickname: '',
    profileImage: '',
  );

  @override
  void onInit() async {
    await fetch();
    nicknameController.text = buyerProfileEdit.nickname;
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      // BuyerProfile buyerProfile = await _profileRepository.fetchBuyerProfile();
      // buyerProfileEdit = BuyerProfileEdit(
      //   nickname: buyerProfile.nickname,
      //   profileImageUrl: buyerProfile.profileImageUrl,
      // );
      String nickname =
          Get.find<BuyerProfileController>().buyerProfile.value.nickname;
      String profileImageUrl =
          Get.find<BuyerProfileController>().buyerProfile.value.profileImage;
      buyerProfileEdit = BuyerProfileEdit(
        nickname: nickname,
        profileImage: profileImageUrl,
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
      logAnalytics(
          name: 'buyer_profile_edit', parameters: {'action': 'select_image'});
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
    if (value != buyerProfileEdit.nickname) {
      isNicknameChanged.value = true;
    } else {
      isNicknameChanged.value = false;
    }
  }

  Future<void> edit() async {
    await profileRepository.editBuyerProfile(
      isNicknameChanged.value,
      isProfileImageChanged.value,
      nicknameController.text,
      profileImage.value,
    );
  }

  void setFocus(bool focused) {
    isNicknameFocused.value = focused;
  }

  bool isEditable() {
    return isNicknameValid.value &&
        (isNicknameChanged.value || isProfileImageChanged.value);
  }

  Future<void> inactive() async {
    await profileRepository.inactive();
  }
}
