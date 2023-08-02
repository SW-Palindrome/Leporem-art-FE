class Order {
  final int id;
  final int itemId;
  final String title;
  final String thumbnailImage;
  final int price;
  final String orderedDatetime;
  String orderStatus;
  final bool isReviewed;

  Order({
    required this.id,
    required this.itemId,
    required this.title,
    required this.thumbnailImage,
    required this.price,
    required this.orderedDatetime,
    required this.orderStatus,
    this.isReviewed = false,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'],
      itemId: json['item_id'],
      title: json['item_title'],
      thumbnailImage: json['item_thumbnail_image'],
      price: json['price'],
      orderedDatetime: json['ordered_datetime'],
      orderStatus: json['order_status'],
    );
  }
}
