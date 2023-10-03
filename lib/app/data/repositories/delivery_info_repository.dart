import '../provider/api.dart';

class DeliveryInfoRepository {
  final ApiClient apiClient;
  DeliveryInfoRepository({required this.apiClient}) : assert(apiClient != null);

  Future<String> fetchDeliveryInfoUrl(int orderId) async {
    return apiClient.fetchDeliveryInfoUrl(orderId);
  }
}
