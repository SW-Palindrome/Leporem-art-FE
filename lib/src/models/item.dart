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
      isLiked: json['is_liked'],
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
  final int currentAmount;
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
    required this.currentAmount,
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
      currentAmount: json['current_amount'],
      star: json['avg_rating'],
      //TODO: timeAgo 시간 표시 추후 구현
      timeDiff: json['time_diff'],
      isAuction: json['is_auction'] ?? false,
    );
  }
}

class RecentItem {
  final int id;
  final String nickname;
  final String title;
  final int price;
  final String thumbnailImage;
  bool isLiked;

  RecentItem({
    required this.id,
    required this.nickname,
    required this.title,
    required this.price,
    required this.thumbnailImage,
    required this.isLiked,
  });

  factory RecentItem.fromJson(Map<String, dynamic> json) {
    return RecentItem(
      id: json['item_id'],
      nickname: json['nickname'],
      title: json['title'],
      price: json['price'],
      thumbnailImage: json['thumbnail_image'],
      isLiked: json['is_liked'],
    );
  }

  void like() {
    isLiked = true;
  }

  void unlike() {
    isLiked = false;
  }
}

class MessageItem {
  final int id;
  final String title;
  final String nickname;
  final int price;
  final String thumbnailImage;
  final int currentAmount;
  MessageItem({
    required this.id,
    required this.title,
    required this.nickname,
    required this.price,
    required this.thumbnailImage,
    required this.currentAmount,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) {
    return MessageItem(
      id: json['item_id'],
      title: json['title'],
      nickname: json['nickname'],
      price: json['price'],
      thumbnailImage: json['thumbnail_image'],
      currentAmount: json['current_amount'],
    );
  }
}
