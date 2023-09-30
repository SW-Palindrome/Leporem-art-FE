import '../provider/api.dart';

class ReviewRepository {
  final ApiClient apiClient;
  ReviewRepository({required this.apiClient}) : assert(apiClient != null);

  Future<void> createReview(int orderId, int star, String description) async {
    await apiClient.createReview(orderId, star, description);
  }
}
