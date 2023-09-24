import 'package:get/get.dart';

import '../../controller/buyer/item_creator/item_creator_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/profile_repository.dart';

class ItemCreatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemCreatorController>(() {
      return ItemCreatorController(
          homeRepository: HomeRepository(apiClient: DioClient()),
          profileRepository: ProfileRepository(apiClient: DioClient()));
    });
  }
}
