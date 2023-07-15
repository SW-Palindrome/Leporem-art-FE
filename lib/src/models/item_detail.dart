class ItemDetail {
  final int id;
  final String profileImageUrl;
  final String creator;
  final double temperature;
  final String name;
  final String description;
  final int price;
  final List<String> tags;
  final int remainAmount;
  final List<String> imagesUrl;
  final String videoUrl;
  final bool isLiked;

  ItemDetail({
    required this.id,
    required this.profileImageUrl,
    required this.creator,
    required this.temperature,
    required this.name,
    required this.description,
    required this.price,
    required this.tags,
    required this.remainAmount,
    required this.imagesUrl,
    required this.videoUrl,
    required this.isLiked,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      id: json['id'],
      profileImageUrl: json['profileImageUrl'],
      creator: json['creator'],
      temperature: json['temperature'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      tags: json['tags'],
      remainAmount: json['remainAmount'],
      imagesUrl: json['imagesUrl'],
      videoUrl: json['videoUrl'],
      isLiked: json['isLiked'],
    );
  }
}
