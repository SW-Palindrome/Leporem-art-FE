class Profile {
  final String nickname;
  final String profileImageUrl;

  Profile({
    required this.nickname,
    required this.profileImageUrl,
  });
}

class BuyerProfile extends Profile {
  final bool isSeller;

  BuyerProfile({
    required String nickname,
    required String profileImageUrl,
    required this.isSeller,
  }) : super(
          nickname: nickname,
          profileImageUrl: profileImageUrl,
        );

  factory BuyerProfile.fromJson(Map<String, dynamic> json) {
    return BuyerProfile(
      nickname: json['nickname'],
      profileImageUrl: json['profile_image'] ??
          'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      isSeller: json['is_seller'],
    );
  }
}

class SellerProfile extends Profile {
  final int itemCount;
  final double temperature;
  final String description;

  SellerProfile({
    required String nickname,
    required String profileImageUrl,
    required this.itemCount,
    required this.temperature,
    required this.description,
  }) : super(
          nickname: nickname,
          profileImageUrl: profileImageUrl,
        );

  factory SellerProfile.fromJson(Map<String, dynamic> json) {
    return SellerProfile(
      nickname: json['nickname'],
      profileImageUrl: json['profile_image'] ??
          'https://leporem-art-media-dev.s3.ap-northeast-2.amazonaws.com/user/profile_images/default.png',
      itemCount: json['item_count'],
      temperature: json['temperature'] ?? 36.5,
      description: json['description'] ?? '',
    );
  }
}
