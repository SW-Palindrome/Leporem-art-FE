import 'package:get/get.dart';

import '../../controller/seller/exhibition/exhibition_controller.dart';
import '../../controller/seller/home/seller_home_controller.dart';
import '../../controller/seller/profile/seller_profile_controller.dart';
import '../../controller/seller/search/seller_search_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/exhibition_repository.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/profile_repository.dart';

class SellerAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellerSearchController());
    Get.lazyPut(() => SellerHomeController(
        repository: HomeRepository(apiClient: DioClient())));
    Get.lazyPut(() => SellerProfileController(
        repository: ProfileRepository(apiClient: DioClient())));
    Get.lazyPut(() => ExhibitionController(
        repository: ExhibitionRepository(apiClient: DioClient())));
  }
}
