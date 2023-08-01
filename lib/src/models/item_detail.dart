class ItemDetail {
  final int id;
  final String profileImage;
  final String nickname;
  final double? temperature;
  final String title;
  final String description;
  final int price;
  final List<String> category;
  int currentAmount;
  final String thumbnailImage;
  final List<String> images;
  final String shorts;
  bool isLiked;
  final String? width;
  final String? depth;
  final String? height;

  ItemDetail({
    required this.id,
    required this.profileImage,
    required this.nickname,
    required this.temperature,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.currentAmount,
    required this.thumbnailImage,
    required this.images,
    required this.shorts,
    required this.isLiked,
    required this.width,
    required this.depth,
    required this.height,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      id: json['item_id'],
      profileImage: json['profile_image'],
      nickname: json['nickname'],
      temperature: json['temperature'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      currentAmount: json['current_amount'],
      thumbnailImage: json['thumbnail_image'],
      images: List<String>.from(json['images']),
      category: List<String>.from(json['category']),
      shorts: json['shorts'],
      isLiked: json['like'],
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
    );
  }

  ItemDetail like() {
    return ItemDetail(
      id: id,
      profileImage: profileImage,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount,
      thumbnailImage: thumbnailImage,
      images: images,
      category: category,
      shorts: shorts,
      isLiked: true,
      width: width,
      depth: depth,
      height: height,
    );
  }

  ItemDetail unlike() {
    return ItemDetail(
      id: id,
      profileImage: profileImage,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount,
      thumbnailImage: thumbnailImage,
      images: images,
      category: category,
      shorts: shorts,
      isLiked: false,
      width: width,
      depth: depth,
      height: height,
    );
  }

  ItemDetail decreaseAmount() {
    return ItemDetail(
      id: id,
      profileImage: profileImage,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount - 1,
      thumbnailImage: thumbnailImage,
      images: images,
      category: category,
      shorts: shorts,
      isLiked: isLiked,
      width: width,
      depth: depth,
      height: height,
    );
  }

  ItemDetail increaseAmount() {
    return ItemDetail(
      id: id,
      profileImage: profileImage,
      nickname: nickname,
      temperature: temperature,
      title: title,
      description: description,
      price: price,
      currentAmount: currentAmount + 1,
      thumbnailImage: thumbnailImage,
      images: images,
      category: category,
      shorts: shorts,
      isLiked: isLiked,
      width: width,
      depth: depth,
      height: height,
    );
  }
}
