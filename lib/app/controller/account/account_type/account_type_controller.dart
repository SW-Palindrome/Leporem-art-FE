import 'package:get/get.dart';

class AccountTypeController extends GetxController {
  RxBool isSelect = false.obs;
  RxList<bool> typeList = [false, false].obs;

  void selectType(int index) {
    isSelect.value = true;
    for (int i = 0; i < typeList.length; i++) {
      if (i == index) {
        typeList[i] = true;
      } else {
        typeList[i] = false;
      }
    }
  }
}
