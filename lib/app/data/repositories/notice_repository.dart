import '../models/notice.dart';
import '../provider/local.dart';

class NoticeRepository {
  final LocalClient localClient;
  NoticeRepository({required this.localClient}) : assert(localClient != null);

  Future<List<Notice>> getNotices() async {
    return localClient.getNotices();
  }
}
