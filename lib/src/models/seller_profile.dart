class SellerProfile {
  final String nickname;
  final String profileImageUrl;
  final int itemCount;
  final double temperature;
  final String description;

  SellerProfile({
    required this.nickname,
    required this.profileImageUrl,
    required this.itemCount,
    required this.temperature,
    required this.description,
  });

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
