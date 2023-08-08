class BuyerItemDetail {
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

  BuyerItemDetail({
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

  factory BuyerItemDetail.fromJson(Map<String, dynamic> json) {
    return BuyerItemDetail(
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
      isLiked: json['is_liked'],
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
    );
  }

  BuyerItemDetail like() {
    return BuyerItemDetail(
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

  BuyerItemDetail unlike() {
    return BuyerItemDetail(
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
}

class SellerItemDetail {
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
  final String? width;
  final String? depth;
  final String? height;
  final List<Review> reviews;

  SellerItemDetail({
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
    required this.width,
    required this.depth,
    required this.height,
    required this.reviews,
  });

  factory SellerItemDetail.fromJson(Map<String, dynamic> json) {
    List<dynamic> reviewsList = json['reviews'];
    List<Review> reviews =
        reviewsList.map((review) => Review.fromJson(review)).toList();
    return SellerItemDetail(
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
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
      reviews: reviews,
    );
  }

  SellerItemDetail decreaseAmount() {
    return SellerItemDetail(
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
      width: width,
      depth: depth,
      height: height,
      reviews: reviews,
    );
  }

  SellerItemDetail increaseAmount() {
    return SellerItemDetail(
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
      width: width,
      depth: depth,
      height: height,
      reviews: reviews,
    );
  }
}

class Review {
  final String comment;
  final String rating;
  final String writer;
  final String writeDateTime;

  Review({
    required this.comment,
    required this.rating,
    required this.writer,
    required this.writeDateTime,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
      rating: json['rating'],
      writer: json['writer'],
      writeDateTime: json['write_dt'],
    );
  }
}
