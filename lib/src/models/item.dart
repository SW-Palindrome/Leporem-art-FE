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
      id: json['id'],
      name: json['name'],
      creator: json['creator'],
      price: json['price'],
      thumbnailUrl: json['thumbnailUrl'],
      likes: json['likes'],
      isLiked: json['isLiked'],
    );
  }
}
