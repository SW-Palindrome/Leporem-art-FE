import 'package:leporemart/app/data/provider/api.dart';

class SellerItemDeliveryEditRepository {
  final ApiClient apiClient;
  SellerItemDeliveryEditRepository({required this.apiClient}) : assert(apiClient != null);

  Future<void> updateDeliveryInfo(int orderId, String deliveryCompany, String invoiceNumber) async {
    return apiClient.updateDeliveryInfo(orderId, deliveryCompany, invoiceNumber);
  }
}