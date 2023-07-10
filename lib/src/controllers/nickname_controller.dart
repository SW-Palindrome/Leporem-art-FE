import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NicknameController extends GetxController {
  static NicknameController get to => Get.find();

  TextEditingController nicknameController = TextEditingController();

  Rx<bool> isNicknameValid = false.obs;
  Rx<bool> isDisplayError = false.obs;
  Rx<bool> isFocused = false.obs;

  void checkNickname(String value) {
    RegExp regExp = RegExp(r'^[\w가-힣_-]{2,10}$');
    isNicknameValid.value = regExp.hasMatch(value);
  }

  void setDisplayError(bool display) {
    isDisplayError.value = display;
  }

  void setFocus(bool focused) {
    isFocused.value = focused;
  }
}
