import 'package:get/get.dart';

import '../../controller/account/account_type/account_type_controller.dart';
import '../../controller/account/agreement/agreement_controller.dart';
import '../../controller/account/email/email_controller.dart';
import '../../controller/account/nickname/nickname_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/email_repository.dart';
import '../../data/repositories/nickname_repository.dart';
import '../../data/repositories/signup_repository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgreementController());
    Get.lazyPut(() => AccountTypeController());
    Get.lazyPut(() =>
        EmailController(repository: EmailRepository(apiClient: DioClient())));
    Get.lazyPut(() => NicknameController(
        nicknameRepository: NicknameRepository(apiClient: DioClient()),
        signupRepository: SignupRepository(apiClient: DioClient())));
  }
}
