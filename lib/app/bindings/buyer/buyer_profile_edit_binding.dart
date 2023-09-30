import 'package:get/get.dart';

import '../../controller/buyer/profile_edit/buyer_profile_edit_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/nickname_repository.dart';
import '../../data/repositories/profile_repository.dart';

class BuyerProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerProfileEditController>(
      () => BuyerProfileEditController(
          nicknameRepository: NicknameRepository(apiClient: DioClient()),
          profileRepository: ProfileRepository(apiClient: DioClient())),
    );
  }
}
