class BuyerProfileEdit {
  final String nickname;
  final String profileImageUrl;
  final String description;

  BuyerProfileEdit({
    required this.nickname,
    required this.profileImageUrl,
    required this.description,
  });

  factory BuyerProfileEdit.fromJson(Map<String, dynamic> json) {
    return BuyerProfileEdit(
      nickname: json['nickname'],
      profileImageUrl: json['profile_image'] ??
          'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/309/59932b0eb046f9fa3e063b8875032edd_crop.jpeg',
      description: json['description'],
    );
  }
}
