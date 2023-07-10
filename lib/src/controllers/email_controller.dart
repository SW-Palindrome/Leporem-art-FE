import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  static EmailController get to => Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Rx<bool> isEmailValid = false.obs;
  Rx<bool> isDisplayError = false.obs;
  Rx<bool> isFocused = false.obs;
  Rx<bool> isSendClicked = false.obs;

  Rx<bool> isCodeError = false.obs;

  void checkEmail(String value) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-99+\-_.]+@([a-zA-Z0-9]+\.)+(ac\.kr)$');
    isEmailValid.value = regExp.hasMatch(value);
  }

  void setDisplayError(bool display) {
    isDisplayError.value = display;
  }

  void setFocus(bool focused) {
    isFocused.value = focused;
  }

  void setSendClicked(bool clicked) {
    isSendClicked.value = clicked;
  }

  void checkCode(String code) {
    isCodeError.value = code != "123456";
  }
}
