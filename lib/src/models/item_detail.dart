class ItemDetail {
  final int id;
  final String profileImageUrl;
  final String nickname;
  final double? temperature;
  final String title;
  final String description;
  final int price;
  final List<String> category;
  int currentAmount;
  final String thumbnailUrl;
  final List<String> imagesUrl;
  final String videoUrl;
  bool isLiked;
  final String? width;
  final String? depth;
  final String? height;

  ItemDetail({
    required this.id,
    required this.profileImageUrl,
    required this.nickname,
    required this.temperature,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.currentAmount,
    required this.thumbnailUrl,
    required this.imagesUrl,
    required this.videoUrl,
    required this.isLiked,
    required this.width,
    required this.depth,
    required this.height,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      id: json['item_id'],
      profileImageUrl: json['profile_image'],
      nickname: json['nickname'],
      temperature: json['temperature'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      currentAmount: json['current_amount'],
      thumbnailUrl: json['thumbnail_image'],
      imagesUrl: List<String>.from(json['images']),
      category: List<String>.from(json['category']),
      videoUrl: json['shorts'],
      isLiked: json['like'],
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
    );
  }

  ItemDetail like() {
    return ItemDetail(
      id: id,
      profileImageUrl: profileImageUrl,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount,
      thumbnailUrl: thumbnailUrl,
      imagesUrl: imagesUrl,
      category: category,
      videoUrl: videoUrl,
      isLiked: true,
      width: width,
      depth: depth,
      height: height,
    );
  }

  ItemDetail unlike() {
    return ItemDetail(
      id: id,
      profileImageUrl: profileImageUrl,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount,
      thumbnailUrl: thumbnailUrl,
      imagesUrl: imagesUrl,
      category: category,
      videoUrl: videoUrl,
      isLiked: false,
      width: width,
      depth: depth,
      height: height,
    );
  }

  ItemDetail decreaseAmount() {
    return ItemDetail(
      id: id,
      profileImageUrl: profileImageUrl,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount - 1,
      thumbnailUrl: thumbnailUrl,
      imagesUrl: imagesUrl,
      category: category,
      videoUrl: videoUrl,
      isLiked: isLiked,
      width: width,
      depth: depth,
      height: height,
    );
  }

  ItemDetail increaseAmount() {
    return ItemDetail(
      id: id,
      profileImageUrl: profileImageUrl,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount + 1,
      thumbnailUrl: thumbnailUrl,
      imagesUrl: imagesUrl,
      category: category,
      videoUrl: videoUrl,
      isLiked: isLiked,
      width: width,
      depth: depth,
      height: height,
    );
  }
}
