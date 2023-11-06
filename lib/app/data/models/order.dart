class Order {
  final int id;
  final int itemId;
  final String title;
  final String thumbnailImage;
  final int price;
  final String orderedDatetime;
  String orderStatus;
  final bool isReviewed;
  final String buyerName;
  final String address;
  final String addressDetail;
  final String zipCode;
  final String phoneNumber;

  Order({
    required this.id,
    required this.itemId,
    required this.title,
    required this.thumbnailImage,
    required this.price,
    required this.orderedDatetime,
    required this.orderStatus,
    required this.isReviewed,
    required this.buyerName,
    required this.address,
    required this.addressDetail,
    required this.zipCode,
    required this.phoneNumber,
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
    required buyerName,
    required address,
    required addressDetail,
    required zipCode,
    required phoneNumber,
  }) : super(
          id: id,
          itemId: itemId,
          title: title,
          thumbnailImage: thumbnailImage,
          price: price,
          orderedDatetime: orderedDatetime,
          orderStatus: orderStatus,
          isReviewed: isReviewed,
          buyerName: buyerName,
          address: address,
          addressDetail: addressDetail,
          zipCode: zipCode,
          phoneNumber: phoneNumber,
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
      buyerName: json['name'],
      address: json['address'],
      addressDetail: json['detail_address'],
      zipCode: json['zipcode'],
      phoneNumber: json['phone_number'],
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
    required buyerName,
    required address,
    required addressDetail,
    required zipCode,
    required phoneNumber,
  }) : super(
          id: id,
          itemId: itemId,
          title: title,
          thumbnailImage: thumbnailImage,
          price: price,
          orderedDatetime: orderedDatetime,
          orderStatus: orderStatus,
          isReviewed: isReviewed,
          buyerName: buyerName,
          address: address,
          addressDetail: addressDetail,
          zipCode: zipCode,
          phoneNumber: phoneNumber,
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
      addressDetail: json['detail_address'],
      zipCode: json['zipcode'],
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
    buyerName = '',
    address = '',
    addressDetail = '',
    zipCode = '',
    phoneNumber = '',
  }) : super(
          id: id,
          itemId: itemId,
          title: title,
          thumbnailImage: thumbnailImage,
          price: price,
          orderedDatetime: orderedDatetime,
          orderStatus: orderStatus,
          isReviewed: isReviewed,
          buyerName: buyerName,
          address: address,
          addressDetail: addressDetail,
          zipCode: zipCode,
          phoneNumber: phoneNumber,
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
