import 'package:get/get.dart';

class MessageItemShareController extends GetxController {
  Rx<int> selectIndex = 0.obs;
  Rx<bool> isSelect = false.obs;

  void select(int index) {
    if (selectIndex.value == index) {
      isSelect.value = !isSelect.value;
    } else {
      selectIndex.value = index;
      isSelect.value = true;
    }
  }

  bool isSelected(int index) {
    return selectIndex.value == index && isSelect.value;
  }
}
