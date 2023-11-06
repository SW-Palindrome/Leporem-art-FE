import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/data/repositories/email_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/provider/dio.dart';

class EmailController extends GetxController {
  final EmailRepository repository;
  EmailController({required this.repository}) : assert(repository != null);

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Rx<bool> isEmailValid = false.obs;
  Rx<bool> isDisplayError = false.obs;
  Rx<bool> isFocused = false.obs;
  Rx<bool> isSendClicked = false.obs;

  Rx<bool> isCodeError = false.obs;
  Rx<bool> isCodeValid = false.obs;

  void checkEmail(String value) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9\.]+\.[a-zA-Z\.]+');
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

  void isCodeValidated(String value) {
    isCodeValid.value = value.length == 6;
  }

  Future<void> checkCode() async {
    isCodeError.value = await repository.checkCode(codeController.text);
  }

  Future<void> sendEmail() async {
    await repository.sendEmail(emailController.text);
  }

  void reset() {
    emailController.clear();
    codeController.clear();
    isEmailValid.value = false;
    isDisplayError.value = false;
    isFocused.value = false;
    isSendClicked.value = false;
    isCodeError.value = false;
    isCodeValid.value = false;
  }
}
