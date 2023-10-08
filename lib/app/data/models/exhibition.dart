class Exhibition {
  final int id;
  final String title;
  final String coverImage;
  final String seller;
  final String startDate;
  final String endDate;

  Exhibition({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.seller,
    required this.startDate,
    required this.endDate,
  });

  factory Exhibition.fromJson(Map<String, dynamic> json) {
    return Exhibition(
      id: json['id'],
      title: json['title'],
      coverImage: json['cover_image'],
      seller: json['seller'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class ExhibitionArtist {
  final String backgroundColor;
  final String fontFamily;
  final String imageUrl;
  final String description;

  ExhibitionArtist({
    required this.backgroundColor,
    required this.fontFamily,
    required this.imageUrl,
    required this.description,
  });

  factory ExhibitionArtist.fromJson(Map<String, dynamic> json) {
    return ExhibitionArtist(
      backgroundColor: json['background_color'],
      fontFamily: json['font_family'],
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }
}

class ExhibitionItem {
  final int id;
  final bool isUsingTemplate;
  final String fontFamily;
  final String backgroundColor;
  final List<String> imageUrls;
  final String? audioUrl;
  final String title;
  final String description;
  final bool isSoled;
  final int position;

  // 판매 추가 정보
  final int? price;
  final String? category;
  final String? shorts;
  final int? currentAmount;
  final String? width;
  final String? depth;
  final String? height;

  ExhibitionItem({
    required this.id,
    required this.isUsingTemplate,
    required this.fontFamily,
    required this.backgroundColor,
    required this.imageUrls,
    this.audioUrl,
    required this.title,
    required this.description,
    required this.isSoled,
    required this.position,
    this.price,
    this.category,
    this.shorts,
    this.currentAmount,
    this.width,
    this.depth,
    this.height,
  });

  factory ExhibitionItem.fromJson(Map<String, dynamic> json) {
    return ExhibitionItem(
      id: json['id'],
      isUsingTemplate: json['is_using_template'],
      fontFamily: json['font_family'],
      backgroundColor: json['background_color'],
      imageUrls: json['image_urls'].cast<String>(),
      audioUrl: json['audio_url'],
      title: json['title'],
      description: json['description'],
      isSoled: json['is_soled'],
      position: json['position'],
      price: json['price'],
      category: json['category'],
      shorts: json['shorts'],
      currentAmount: json['current_amount'],
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
    );
  }
}
