import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
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

  void signup() async {
    Dio dio = DioSingleton.dio;
    String? idToken = await getIDToken();
    if (idToken == null) {
      // ID Token을 가져오는 데 실패한 경우 처리
      return;
    }

    dio.post("users/signup/kakao", data: {
      "id_token": idToken,
      "nickname": nicknameController.text,
      "is_agreed_privacy": true,
      "is_agreed_ads": true,
    }).then((response) {
      // 요청에 대한 처리
      print(response.data);
    }).catchError((error) {
      // 오류 처리
      print(error);
    });
  }
}
