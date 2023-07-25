class BuyerHomeItem {
  final int id;
  final String name;
  final String creator;
  final int price;
  final String thumbnailUrl;
  final int likes;
  final bool isLiked;

  BuyerHomeItem({
    required this.id,
    required this.name,
    required this.creator,
    required this.price,
    required this.thumbnailUrl,
    required this.likes,
    required this.isLiked,
  });

  factory BuyerHomeItem.fromJson(Map<String, dynamic> json) {
    return BuyerHomeItem(
      id: json['item_id'],
      name: json['title'],
      creator: json['nickname'],
      price: json['price'],
      thumbnailUrl: json['thumbnail_image'],
      likes: json['likes'],
      //TODO: isLiked 좋아요했는지 여부 추후 구현
      isLiked: json['isLiked'] ?? false,
    );
  }
}

class SellerHomeItem {
  final int id;
  final String name;
  final String creator;
  final int price;
  final String thumbnailUrl;
  final int likes;
  final int messages;
  final int remainAmount;
  final double star;
  final String timeAgo;
  final bool isAuction;

  SellerHomeItem({
    required this.id,
    required this.name,
    required this.creator,
    required this.price,
    required this.thumbnailUrl,
    required this.likes,
    required this.messages,
    required this.remainAmount,
    required this.star,
    required this.timeAgo,
    required this.isAuction,
  });

  factory SellerHomeItem.fromJson(Map<String, dynamic> json) {
    return SellerHomeItem(
      id: json['item_id'],
      name: json['title'],
      creator: json['nickname'],
      price: json['price'],
      thumbnailUrl: json['thumbnail_image'],
      likes: json['likes'],
      messages: json['messages'],
      remainAmount: json['remain_amount'],
      star: json['star'],
      //TODO: timeAgo 시간 표시 추후 구현
      timeAgo: json['time_ago'] ?? '1분 전',
      isAuction: json['is_auction'] ?? false,
    );
  }
}
