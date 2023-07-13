import 'package:get/get.dart';

class ItemDetailController extends GetxController {
  Rx<int> index = 0.obs;

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }
}
