class Exhibition {
  final int id;
  final String title;
  final String coverImage;
  final String seller;
  final DateTime startDateTime;
  final DateTime endDateTime;

  String get startDate => '${startDateTime.year}.${startDateTime.month}.${startDateTime.day}';
  String get endDate => '${endDateTime.year}.${endDateTime.month}.${endDateTime.day}';

  Exhibition({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.seller,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Exhibition.fromJson(Map<String, dynamic> json) {
    return Exhibition(
      id: json['exhibition_id'],
      title: json['title'],
      coverImage: json['cover_image'],
      seller: json['artist_name'],
      startDateTime: DateTime.parse(json['start_date']),
      endDateTime: DateTime.parse(json['end_date']),
    );
  }
}

class ExhibitionArtist {
  final String backgroundColor;
  final String fontFamily;
  final String imageUrl;
  final String description;
  final bool isUsingTemplate;

  ExhibitionArtist({
    required this.backgroundColor,
    required this.fontFamily,
    required this.imageUrl,
    required this.description,
    required this.isUsingTemplate,
  });

  factory ExhibitionArtist.fromJson(Map<String, dynamic> json) {
    return ExhibitionArtist(
      backgroundColor: json['background_color'],
      fontFamily: json['font_family'],
      imageUrl: json['image_url'],
      description: json['description'],
      isUsingTemplate: json['is_using_template'],
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
  final bool isSale;
  final int position;

  // 판매 추가 정보
  final int? price;
  final List<String> category;
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
    required this.isSale,
    required this.position,
    this.price,
    required this.category,
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
      imageUrls: List<String>.from(json['image_urls']),
      audioUrl: json['audio_url'],
      title: json['title'],
      description: json['description'],
      isSale: json['is_sale'],
      position: json['position'],
      price: json['price'],
      category: List<String>.from(json['category']),
      shorts: json['shorts'],
      currentAmount: json['current_amount'],
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
    );
  }
}
