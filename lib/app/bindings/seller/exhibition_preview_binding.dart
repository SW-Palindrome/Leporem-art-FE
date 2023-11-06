import 'package:get/get.dart';
import '../../controller/seller/exhibition/exhibition_preview_controller.dart';
import '../../data/provider/dio.dart';
import '../../data/repositories/exhibition_repository.dart';

class ExhibitionPreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ExhibitionPreviewController(
        repository: ExhibitionRepository(apiClient: DioClient())));
  }
}
