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

  void checkCode(String code) async {
    isCodeError.value = code != "123456";
    Dio dio = DioSingleton.dio;
    String? idToken = await getIDToken();
    dio
        .post("/sellers/verify",
            data: {
              "verify_code": codeController.text,
            },
            options: Options(headers: {"Authorization": "Palindrome $idToken"}))
        .then((response) {
      // 요청에 대한 처리
      print(response.data);
      isCodeError.value = false;
    }).catchError((error) {
      // 오류 처리
      print(error);
      isCodeError.value = true;
    });
  }

  void sendEmail() async {
    Dio dio = DioSingleton.dio;
    String? idToken = await getIDToken();
    if (idToken == null) {
      // ID Token을 가져오는 데 실패한 경우 처리
      return;
    }

    dio
        .post("/sellers/register",
            data: {"email": emailController.text},
            options: Options(headers: {"Authorization": "Palindrome $idToken"}))
        .then((response) {
      // 요청에 대한 처리
      print(response.data);
    }).catchError((error) {
      // 오류 처리
      print(error);
    });
  }
}
