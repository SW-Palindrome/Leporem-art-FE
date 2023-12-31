class Exhibition {
  final int id;
  final String title;
  final String? coverImage;
  final String seller;
  final ExhibitionStatus? status;
  final DateTime startDateTime;
  final DateTime endDateTime;

  String get startDate {
    return '${startDateTime.year}.${startDateTime.month}.${startDateTime.day}';
  }

  String get endDate =>
      '${endDateTime.year}.${endDateTime.month}.${endDateTime.day}';

  Exhibition({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.seller,
    required this.status,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Exhibition.fromJson(Map<String, dynamic> json) {
    ExhibitionStatus? status;
    switch (json['status']) {
      case '생성':
        status = ExhibitionStatus.created;
        break;
      case '소개 작성 완료':
        status = ExhibitionStatus.introductionWritten;
        break;
      case '작가 소개 작성 완료':
        status = ExhibitionStatus.artistWritten;
        break;
      case '작품 등록 완료':
        status = ExhibitionStatus.itemRegistered;
        break;
      default:
        status = ExhibitionStatus.created;
        break;
    }
    return Exhibition(
      id: json['exhibition_id'] ?? -1,
      title: json['title'],
      coverImage: json['cover_image'],
      seller: json['artist_name'],
      status: status,
      startDateTime: DateTime.parse(json['start_date']).toLocal(),
      endDateTime: DateTime.parse(json['end_date']).toLocal(),
    );
  }
}

class ExhibitionArtist {
  final String backgroundColor;
  final String fontFamily;
  final String? imageUrl;
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
    print(json);
    return ExhibitionArtist(
      backgroundColor: json['background_color'] ?? '',
      fontFamily: json['font_family'] ?? '',
      imageUrl: json['artist_image'],
      description: json['biography'] ?? '',
      isUsingTemplate: json['is_template'],
    );
  }
}

class ExhibitionItem {
  final int id;
  final int? template;
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
  final List<String> category = [];
  final String? shorts;
  final int? currentAmount;
  final String? width;
  final String? depth;
  final String? height;

  bool get isUsingTemplate => template != null ? true : false;

  ExhibitionItem({
    required this.id,
    required this.template,
    required this.fontFamily,
    required this.backgroundColor,
    required this.imageUrls,
    this.audioUrl,
    required this.title,
    required this.description,
    required this.isSale,
    required this.position,
    this.price,
    this.shorts,
    this.currentAmount,
    this.width,
    this.depth,
    this.height,
  });

  factory ExhibitionItem.fromJson(Map<String, dynamic> json) {
    return ExhibitionItem(
      id: json['exhibition_item_id'],
      template: json['template'],
      fontFamily: json['font_family'] ?? '0',
      backgroundColor: json['background_color'] ?? '0',
      imageUrls: List<String>.from(json['images']),
      audioUrl: json['sound'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isSale: json['is_sale'],
      position: json['position'],
      price: json['price'],
      shorts: json['shorts'],
      currentAmount: json['max_amount'],
      width: json['width'],
      depth: json['depth'],
      height: json['height'],
    );
  }
}

enum ExhibitionStatus {
  created,
  introductionWritten,
  artistWritten,
  itemRegistered,
}
