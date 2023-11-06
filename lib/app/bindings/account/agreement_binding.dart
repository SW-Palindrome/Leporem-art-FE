import 'package:get/get.dart';

import '../../controller/account/agreement/agreement_controller.dart';

class AgreementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgreementController());
  }
}
