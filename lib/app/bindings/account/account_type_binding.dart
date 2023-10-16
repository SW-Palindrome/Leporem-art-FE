import 'package:get/get.dart';

import '../../controller/account/account_type/account_type_controller.dart';

class AccountTypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountTypeController());
  }
}
