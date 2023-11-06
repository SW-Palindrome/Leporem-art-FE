import 'package:get/get.dart';

import '../../controller/seller/profile_edit/seller_profile_edit_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/nickname_repository.dart';
import '../../data/repositories/profile_repository.dart';

class SellerProfileEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SellerProfileEditController(
        profileRepository: ProfileRepository(apiClient: DioClient()),
        nicknameRepository: NicknameRepository(apiClient: DioClient())));
  }
}
