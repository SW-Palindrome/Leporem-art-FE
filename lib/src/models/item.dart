class BuyerHomeItem {
  final int id;
  final String name;
  final String creator;
  final int price;
  final String thumbnailUrl;
  int likes;
  bool isLiked;

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
      likes: json['like_count'],
      //TODO: isLiked 좋아요했는지 여부 추후 구현
      isLiked: json['is_liked'] ?? false,
    );
  }

  void like() {
    isLiked = true;
    likes++;
  }

  void unlike() {
    isLiked = false;
    likes--;
  }
}

class SellerHomeItem {
  final int id;
  final String name;
  final String creator;
  final int price;
  final String thumbnailUrl;
  final int likes;
  final int remainAmount;
  final String star;
  final String timeAgo;
  final bool isAuction;

  SellerHomeItem({
    required this.id,
    required this.name,
    required this.creator,
    required this.price,
    required this.thumbnailUrl,
    required this.likes,
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
      likes: json['like_count'],
      remainAmount: json['remain_amount'] ?? 0,
      star: json['avg_rating'],
      //TODO: timeAgo 시간 표시 추후 구현
      timeAgo: json['time_diff'],
      isAuction: json['is_auction'] ?? false,
    );
  }
}
