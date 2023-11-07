import 'package:get/get.dart';
import 'package:leporemart/app/data/repositories/notice_repository.dart';

import '../../../data/models/notice.dart';

class NoticeController extends GetxController {
  final NoticeRepository repository;
  NoticeController({required this.repository}) : assert(repository != null);

  RxList<Notice> notices = RxList<Notice>([]);
  RxList<bool> isExpanded = RxList<bool>([]);

  @override
  void onInit() async {
    await getNotices();
    super.onInit();
  }

  Future<void> getNotices() async {
    notices.value = await repository.getNotices();
    isExpanded.value = List<bool>.filled(notices.length, false);
  }

  Future<void> removeNotices() async {
    print('지우기');
    await repository.removeNotices();
    await getNotices();
  }
}
