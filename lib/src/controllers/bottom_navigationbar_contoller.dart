import 'package:get/get.dart';
import 'package:leporemart/src/configs/amplitude_config.dart';

class BottomNavigationbarController extends GetxController {

  static BottomNavigationbarController get to => Get.find();

  // 현재 선택된 탭 아이템 번호 저장
  final RxInt selectedIndex = 0.obs;

  // 탭 이벤트가 발생할 시 selectedIndex값을 변경해줄 함수
  void changeIndex(int index) {
    selectedIndex(index);
    //하단바 선택시 로그
    AmplitudeConfig.analytics.logEvent("Page View", eventProperties: {"Page Name": index});
  }
}
