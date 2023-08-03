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
}

class BuyerOrder extends Order {
  BuyerOrder({
    required id,
    required itemId,
    required title,
    required thumbnailImage,
    required price,
    required orderedDatetime,
    required orderStatus,
    isReviewed = false,
  }) : super(
          id: id,
          itemId: itemId,
          title: title,
          thumbnailImage: thumbnailImage,
          price: price,
          orderedDatetime: orderedDatetime,
          orderStatus: orderStatus,
          isReviewed: isReviewed,
        );

  factory BuyerOrder.fromJson(Map<String, dynamic> json) {
    return BuyerOrder(
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

class SellerOrder extends Order {
  final String buyerNickname;
  SellerOrder({
    required id,
    required itemId,
    required title,
    required thumbnailImage,
    required price,
    required orderedDatetime,
    required orderStatus,
    required this.buyerNickname,
    isReviewed = false,
  }) : super(
          id: id,
          itemId: itemId,
          title: title,
          thumbnailImage: thumbnailImage,
          price: price,
          orderedDatetime: orderedDatetime,
          orderStatus: orderStatus,
          isReviewed: isReviewed,
        );

  factory SellerOrder.fromJson(Map<String, dynamic> json) {
    return SellerOrder(
      id: json['order_id'],
      itemId: json['item_id'],
      title: json['item_title'],
      thumbnailImage: json['item_thumbnail_image'],
      price: json['price'],
      orderedDatetime: json['ordered_datetime'],
      orderStatus: json['order_status'],
      buyerNickname: json['buyer'],
    );
  }
}
