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
          'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/309/59932b0eb046f9fa3e063b8875032edd_crop.jpeg',
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
          'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/309/59932b0eb046f9fa3e063b8875032edd_crop.jpeg',
      itemCount: json['item_count'],
      temperature: json['temperature'],
      description: json['description'],
    );
  }
}
