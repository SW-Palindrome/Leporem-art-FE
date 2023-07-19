class BuyerProfile {
  final String nickname;
  final String profileImageUrl;
  final bool isSeller;

  BuyerProfile({
    required this.nickname,
    required this.profileImageUrl,
    required this.isSeller,
  });

  factory BuyerProfile.fromJson(Map<String, dynamic> json) {
    return BuyerProfile(
      nickname: json['nickname'],
      profileImageUrl: json['profile_image'] ??
          'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/309/59932b0eb046f9fa3e063b8875032edd_crop.jpeg',
      isSeller: json['is_seller'],
    );
  }
}
