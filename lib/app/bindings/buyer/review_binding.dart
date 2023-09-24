import 'package:get/get.dart';

import '../../controller/buyer/review/review_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/review_repository.dart';

class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
        ReviewController(repository: ReviewRepository(apiClient: DioClient())));
  }
}
