import 'package:get/get.dart';

import '../../controller/common/notice/notice_controller.dart';
import '../../data/provider/local.dart';
import '../../data/repositories/notice_repository.dart';

class NoticeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NoticeController(
        repository: NoticeRepository(localClient: LocalClient())));
  }
}
