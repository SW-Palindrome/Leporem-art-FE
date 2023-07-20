import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/models/buyer_profile_edit.dart';
import 'package:leporemart/src/repositories/buyer_profile_edit_repository.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class BuyerProfileEditController extends GetxController {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<bool> isNicknameValid = false.obs;
  Rx<bool> isNicknameDuplicate = false.obs;

  final BuyerProfileEditRepository _buyerProfileEditRepository =
      BuyerProfileEditRepository();
  BuyerProfileEdit buyerProfileEdit = BuyerProfileEdit(
    nickname: '불건전한 소환사명',
    profileImageUrl:
        'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
    description: '설명\n설명\n설명\n설명\n설명\n설명\n',
  );

  @override
  void onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      buyerProfileEdit =
          await _buyerProfileEditRepository.fetchBuyerProfileEdit();
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile edit: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }

  void checkNickname(String value) {
    RegExp regExp = RegExp(r'^[\w가-힣_-]{2,10}$');
    isNicknameValid.value = regExp.hasMatch(value);
  }

  Future<void> isDuplicate(String value) async {
    try {
      final response =
          await DioSingleton.dio.post("/users/validate/nickname/$value");
      if (response.statusCode != 200) {
        isNicknameDuplicate.value = false;
      }
      isNicknameDuplicate.value = true;
    } catch (e) {
      isNicknameDuplicate.value = false;
    }
  }
}
