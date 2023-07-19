class Item {
  final int id;
  final String name;
  final String creator;
  final int price;
  final String thumbnailUrl;
  final int likes;
  final bool isLiked;

  Item({
    required this.id,
    required this.name,
    required this.creator,
    required this.price,
    required this.thumbnailUrl,
    required this.likes,
    required this.isLiked,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
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
