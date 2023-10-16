import 'package:leporemart/app/data/provider/api.dart';

import '../models/item.dart';

class HomeRepository {
  final ApiClient apiClient;
  HomeRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    return apiClient.fetchBuyerHomeItems(
      page,
      keyword: keyword,
      ordering: ordering,
      category: category,
      price: price,
      isPagination: isPagination,
    );
  }

  Future<List<BuyerHomeItem>> fetchGuestHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    return apiClient.fetchGuestHomeItems(
      page,
      keyword: keyword,
      ordering: ordering,
      category: category,
      price: price,
      isPagination: isPagination,
    );
  }

  Future<List<BuyerHomeItem>> fetchBuyerCreatorItems(
    int page, {
    String? nickname,
    isPagination = false,
  }) async {
    return apiClient.fetchBuyerCreatorItems(
      page,
      nickname: nickname,
      isPagination: isPagination,
    );
  }

  Future<List<SellerHomeItem>> fetchSellerHomeItems(
    int page, {
    String? nickname,
    String? ordering,
    String? keyword,
    isPagination = false,
  }) async {
    return apiClient.fetchSellerHomeItems(
      page,
      nickname: nickname,
      ordering: ordering,
      keyword: keyword,
      isPagination: isPagination,
    );
  }

  Future<void> like(int itemId) async {
    return await apiClient.like(itemId);
  }

  Future<void> unlike(int itemId) async {
    return await apiClient.unlike(itemId);
  }

  Future<void> view(int itemId) async {
    return await apiClient.view(itemId);
  }
}
