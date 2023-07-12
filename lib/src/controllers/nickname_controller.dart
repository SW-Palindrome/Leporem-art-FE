import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/screens/account_type.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

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

  bool isDuplicate(String value) {
    return value == "중복";
  }

  void setDisplayError(bool display) {
    isDisplayError.value = display;
  }

  void setFocus(bool focused) {
    isFocused.value = focused;
  }

  Future<bool> signup() async {
    String? idToken = await getIDToken();
    DioSingleton.dio.post("/users/signup/kakao", data: {
      "id_token": idToken,
      "nickname": nicknameController.text,
      "is_agree_privacy": true,
      "is_agree_ads": true,
    }).then((response) {
      print("회원가입 성공 ${response.data}");
      return true;
    }).catchError((error) {
      if (error.response.statusCode == 400) {
        Get.snackbar("회원가입 실패", "잘못된 요청입니다. 다시시도해주세요.");
      } else {
        Get.snackbar("회원가입 실패", "이미 가입하신 계정입니다.");
      }
    });
    return false;
  }
}
