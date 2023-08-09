import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

import 'agreement_controller.dart';

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

  Future<bool> isDuplicate(String value) async {
    try {
      final response =
          await DioSingleton.dio.get("/users/validate/nickname/$value");
      if (response.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  void setDisplayError(bool display) {
    isDisplayError.value = display;
  }

  void setFocus(bool focused) {
    isFocused.value = focused;
  }

  Future<bool> signup() async {
    try {
      String? idToken = await getOAuthToken().then((value) => value!.idToken);
      final response =
          await DioSingleton.dio.post("/users/signup/kakao", data: {
        "id_token": idToken,
        "nickname": nicknameController.text,
        "is_agree_privacy": true,
        "is_agree_terms": true,
        "is_agree_ads": Get.find<AgreementController>().agreedList[2],
      });
      if (response.statusCode == 201) {
        print("회원가입 성공 ${response.data}");
        return true;
      }
      if (response.statusCode == 400) {
        Get.snackbar("회원가입 실패", "잘못된 요청입니다. 다시시도해주세요.");
      }
      return false;
    } catch (e) {
      Get.snackbar("서버 오류", "요청중 오류가 발생했습니다. 다시시도해주세요.");
      return false;
    }
  }
}
