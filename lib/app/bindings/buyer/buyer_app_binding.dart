import 'package:get/get.dart';

import '../../controller/buyer/exhibition/buyer_exhibition_controller.dart';
import '../../controller/buyer/home/buyer_home_controller.dart';
import '../../controller/buyer/profile/buyer_profile_controller.dart';
import '../../controller/buyer/search/buyer_search_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/exhibition_repository.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/profile_repository.dart';

class BuyerAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuyerSearchController());
    Get.lazyPut(() => BuyerHomeController(
        repository: HomeRepository(apiClient: DioClient())));
    Get.lazyPut(() => BuyerProfileController(
        repository: ProfileRepository(apiClient: DioClient())));
    Get.lazyPut(() => BuyerExhibitionController(
        repository: ExhibitionRepository(apiClient: DioClient())));
  }
}
