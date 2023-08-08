class Profile {
  final String nickname;
  final String profileImage;

  Profile({
    required this.nickname,
    required this.profileImage,
  });
}

class BuyerProfile extends Profile {
  final bool isSeller;

  BuyerProfile({
    required String nickname,
    required String profileImage,
    required this.isSeller,
  }) : super(
          nickname: nickname,
          profileImage: profileImage,
        );

  factory BuyerProfile.fromJson(Map<String, dynamic> json) {
    return BuyerProfile(
      nickname: json['nickname'],
      profileImage: json['profile_image'] ??
          'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      isSeller: json['is_seller'],
    );
  }
}

class SellerProfile extends Profile {
  final int sellerId;
  final int userId;
  final int itemCount;
  final int totalTransaction;
  final double temperature;
  final String description;
  final double retentionRate;

  SellerProfile({
    this.sellerId = 0,
    this.userId = 0,
    required String nickname,
    required String profileImageUrl,
    required this.itemCount,
    required this.totalTransaction,
    required this.temperature,
    required this.description,
    required this.retentionRate,
  }) : super(
          nickname: nickname,
          profileImage: profileImageUrl,
        );

  factory SellerProfile.fromJson(Map<String, dynamic> json) {
    return SellerProfile(
      sellerId: json['seller_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      nickname: json['nickname'],
      profileImageUrl: json['profile_image'] ??
          'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      itemCount: json['item_count'] ?? 0,
      totalTransaction: json['total_transactions'] ?? 0,
      temperature: json['temperature'] ?? 36.5,
      description: json['description'] ?? '',
      retentionRate: json['retention_rate'] ?? 0.0,
    );
  }
}
