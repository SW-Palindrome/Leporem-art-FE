import 'package:get/get.dart';
import 'package:leporemart/app/data/provider/dio.dart';
import 'package:leporemart/app/data/repositories/email_repository.dart';

import '../../controller/account/email/email_controller.dart';

class EmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        EmailController(repository: EmailRepository(apiClient: DioClient())));
  }
}
