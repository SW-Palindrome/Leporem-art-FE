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
    required this.isReviewed,
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
    required isReviewed,
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
      isReviewed: json['is_reviewed'],
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

class OrderInfo extends Order {
  final String sellerNickname;

  OrderInfo({
    required id,
    required itemId,
    required title,
    required thumbnailImage,
    required price,
    required orderedDatetime,
    required orderStatus,
    required this.sellerNickname,
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

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
      id: json['order_id'],
      itemId: json['item_id'],
      title: json['item_title'],
      thumbnailImage: json['item_thumbnail_image'],
      price: json['price'],
      orderedDatetime: json['ordered_datetime'],
      orderStatus: json['order_status'],
      sellerNickname: json['seller_nickname'],
    );
  }
}

class DeliveryInfo {
  bool isComplete;
  List<DeliveryDetail> deliveryDetails;

  DeliveryInfo({
    required this.isComplete,
    required this.deliveryDetails,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      isComplete: json['complete'],
      deliveryDetails: List<DeliveryDetail>.from(
        json['trackingDetails'].map(
          (deliveryDetail) => DeliveryDetail.fromJson(deliveryDetail),
        ),
      ),
    );
  }
}

class DeliveryDetail {
  String kind;
  DateTime datetime;
  String place;

  DeliveryDetail({
    required this.kind,
    required this.datetime,
    required this.place,
  });

  factory DeliveryDetail.fromJson(Map<String, dynamic> json) {
    return DeliveryDetail(
      kind: json['kind'],
      datetime: DateTime.parse(json['timeString']),
      place: json['where'],
    );
  }
}
