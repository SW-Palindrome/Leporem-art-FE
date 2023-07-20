import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class EmailController extends GetxController {
  static EmailController get to => Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Rx<bool> isEmailValid = false.obs;
  Rx<bool> isDisplayError = false.obs;
  Rx<bool> isFocused = false.obs;
  Rx<bool> isSendClicked = false.obs;

  Rx<bool> isCodeError = false.obs;
  Rx<bool> isCodeValid = false.obs;

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

  void isCodeValidated(String value) {
    isCodeValid.value = value.length == 6;
  }

  Future<void> checkCode() async {
    try {
      String? idToken = await getOAuthToken().then((value) => value!.idToken);
      final response = await DioSingleton.dio.post(
        "/sellers/verify",
        data: {
          "verify_code": codeController.text,
        },
        options: Options(
          headers: {"Authorization": "Palindrome $idToken"},
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["message"] == "success") {
          print("코드 확인 성공");
          isCodeError.value = false;
        } else {
          print("코드 확인 실패");
          isCodeError.value = true;
        }
      }
      if (response.statusCode == 400) {
        print("코드 확인 실패400");
        isCodeError.value = true;
      }
    } catch (e) {
      print("코드 확인 실패 에러");
      isCodeError.value = true;
    }
  }

  void sendEmail() async {
    try {
      String? idToken = await getOAuthToken().then((value) => value!.idToken);
      final response = await DioSingleton.dio.post(
        "/sellers/register",
        data: {
          "email": emailController.text,
        },
        options: Options(
          headers: {"Authorization": "Palindrome $idToken"},
        ),
      );
      if (response.statusCode == 200) {
        print("이메일 전송 성공");
      }
      if (response.statusCode == 400) {
        print("이메일 전송 실패");
      }
    } catch (e) {
      print("이메일 전송 실패");
    }
  }
}
