import 'package:get/get.dart';

import '../../controller/common/bottom_navigationbar/bottom_navigationbar_contoller.dart';
import '../../controller/common/user_global_info/user_global_info_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserGlobalInfoController());
    Get.put(MyBottomNavigationbarController());
  }
}
