import '../models/item.dart';
import '../provider/api.dart';

class MessageItemRepository {
  final ApiClient apiClient;
  MessageItemRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<MessageItem>> fetchShareMessageItem(int page,
      {String? nickname}) async {
    return apiClient.fetchShareMessageItem(page, nickname: nickname);
  }

  Future<List<MessageItem>> fetchOrderMessageItem(int page,
      {String? nickname}) async {
    return apiClient.fetchOrderMessageItem(page, nickname: nickname);
  }

  Future<int?> orderItem(int itemId) async {
    return apiClient.orderItem(itemId);
  }
}
