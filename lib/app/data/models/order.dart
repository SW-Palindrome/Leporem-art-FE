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
  final String buyerName;
  final String address;
  final String addressDetail;
  final String zipCode;
  final String phoneNumber;

  SellerOrder({
    required id,
    required itemId,
    required title,
    required thumbnailImage,
    required price,
    required orderedDatetime,
    required orderStatus,
    required this.buyerNickname,
    required this.buyerName,
    required this.address,
    required this.addressDetail,
    required this.zipCode,
    required this.phoneNumber,
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
      buyerName: json['buyer_name'],
      address: json['address'],
      addressDetail: json['address_detail'],
      zipCode: json['zip_code'],
      phoneNumber: json['phone_number'],
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
