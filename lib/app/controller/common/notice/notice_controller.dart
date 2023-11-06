import 'package:get/get.dart';
import 'package:leporemart/app/data/repositories/notice_repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository repository;
  NoticeController({required this.repository}) : assert(repository != null);
}
