class DeliveryInfo {
  String deliveryCompany;
  String invoiceNumber;

  DeliveryInfo({
    required this.deliveryCompany,
    required this.invoiceNumber,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      deliveryCompany: json['delivery_company'],
      invoiceNumber: json['invoice_number'],
    );
  }
}