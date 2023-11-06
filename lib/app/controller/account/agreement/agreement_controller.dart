import 'package:get/get.dart';

class AgreementController extends GetxController {
  RxBool allAgreed = false.obs;
  RxList<bool> agreedList = [false, false, false].obs;

  bool get isNextButtonEnabled => agreedList[0] && agreedList[1];

  void toggleAllAgreed() {
    allAgreed.value = !allAgreed.value;
    agreedList[0] = allAgreed.value;
    agreedList[1] = allAgreed.value;
    agreedList[2] = allAgreed.value;
  }

  void toggleAgreed(int index) {
    agreedList[index] = !agreedList[index];
    allAgreed.value = agreedList[0] && agreedList[1] && agreedList[2];
  }
}
