import 'package:get/get.dart';
import 'package:leporemart/app/data/provider/dio.dart';

import '../../controller/account/nickname/nickname_controller.dart';
import '../../data/repositories/nickname_repository.dart';
import '../../data/repositories/signup_repository.dart';

class NicknameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NicknameController(
        nicknameRepository: NicknameRepository(apiClient: DioClient()),
        signupRepository: SignupRepository(apiClient: DioClient())));
  }
}
