import 'package:get/get.dart';
import 'package:leporemart/app/data/provider/dio.dart';

import '../../controller/buyer/recent_item/recent_item_controller.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/recent_item_repository.dart';

class RecentItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentItemController(
        homeRepository: HomeRepository(apiClient: DioClient()),
        recentItemRepository: RecentItemRepository(apiClient: DioClient())));
  }
}
