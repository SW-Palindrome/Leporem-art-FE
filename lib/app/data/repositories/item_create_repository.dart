import 'package:dio/dio.dart';
import 'package:leporemart/app/data/provider/api.dart';

class ItemCreateRepository {
  final ApiClient apiClient;
  ItemCreateRepository({required this.apiClient}) : assert(apiClient != null);

  Future<dynamic> getPreSignedUrl(String extension) async {
    return await apiClient.getPreSignedUrl(extension);
  }

  Future<dynamic> createItem(FormData formData) async {
    return await apiClient.createItem(formData);
  }

  Future<dynamic> editItem(int itemId, FormData formData) async {
    return await apiClient.editItem(itemId, formData);
  }
}
