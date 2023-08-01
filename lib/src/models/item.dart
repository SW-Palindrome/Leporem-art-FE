class BuyerHomeItem {
  final int id;
  final String title;
  final String nickname;
  final int price;
  final String thumbnailImage;
  int likes;
  bool isLiked;

  BuyerHomeItem({
    required this.id,
    required this.title,
    required this.nickname,
    required this.price,
    required this.thumbnailImage,
    required this.likes,
    required this.isLiked,
  });

  factory BuyerHomeItem.fromJson(Map<String, dynamic> json) {
    return BuyerHomeItem(
      id: json['item_id'],
      title: json['title'],
      nickname: json['nickname'],
      price: json['price'],
      thumbnailImage: json['thumbnail_image'],
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
  final String title;
  final String nickname;
  final int price;
  final String thumbnailImage;
  final int likes;
  final int remainAmount;
  final String star;
  final String timeDiff;
  final bool isAuction;

  SellerHomeItem({
    required this.id,
    required this.title,
    required this.nickname,
    required this.price,
    required this.thumbnailImage,
    required this.likes,
    required this.remainAmount,
    required this.star,
    required this.timeDiff,
    required this.isAuction,
  });

  factory SellerHomeItem.fromJson(Map<String, dynamic> json) {
    return SellerHomeItem(
      id: json['item_id'],
      title: json['title'],
      nickname: json['nickname'],
      price: json['price'],
      thumbnailImage: json['thumbnail_image'],
      likes: json['like_count'],
      remainAmount: json['remain_amount'] ?? 0,
      star: json['avg_rating'],
      //TODO: timeAgo 시간 표시 추후 구현
      timeDiff: json['time_diff'],
      isAuction: json['is_auction'] ?? false,
    );
  }
}
