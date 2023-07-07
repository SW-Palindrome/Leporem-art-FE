import 'package:get/get.dart';

class AccountTypeController extends GetxController {
  static AccountTypeController get to => Get.find();
  RxBool isSelect = false.obs;
  RxList<bool> typeList = [false, false].obs;

  void toggleSelect(int index) {
    isSelect.value = true;
    typeList[index] = !typeList[index];
    typeList.refresh();
  }
}
