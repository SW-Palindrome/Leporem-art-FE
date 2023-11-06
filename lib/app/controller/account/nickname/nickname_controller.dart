import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/login_config.dart';
import '../../../data/repositories/nickname_repository.dart';
import '../../../data/repositories/signup_repository.dart';

class NicknameController extends GetxController {
  final NicknameRepository nicknameRepository;
  final SignupRepository signupRepository;
  NicknameController(
      {required this.nicknameRepository, required this.signupRepository})
      : assert(nicknameRepository != null && signupRepository != null);

  TextEditingController nicknameController = TextEditingController();

  Rx<bool> isNicknameValid = false.obs;
  Rx<bool> isDisplayError = false.obs;
  Rx<bool> isFocused = false.obs;

  late LoginPlatform loginPlatform;
  late String userIdentifier;

  void checkNickname(String value) {
    RegExp regExp = RegExp(r'^[\w가-힣_-]{2,10}$');
    isNicknameValid.value = regExp.hasMatch(value);
  }

  Future<bool> isDuplicate(String nickname) async {
    return await nicknameRepository.isDuplicate(nickname);
  }

  void setDisplayError(bool display) {
    isDisplayError.value = display;
  }

  void setFocus(bool focused) {
    isFocused.value = focused;
  }

  Future<bool> signupWithKakao() async {
    return await signupRepository.signupWithKakao(nicknameController.text);
  }

  Future<bool> signupWithApple() async {
    return await signupRepository.signupWithApple(
        userIdentifier, nicknameController.text);
  }
}
