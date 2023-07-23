class ProfileEdit {
  final String nickname;
  final String profileImageUrl;

  ProfileEdit({
    required this.nickname,
    required this.profileImageUrl,
  });
}

class BuyerProfileEdit extends ProfileEdit {
  BuyerProfileEdit({
    required String nickname,
    required String profileImageUrl,
  }) : super(
          nickname: nickname,
          profileImageUrl: profileImageUrl,
        );

  factory BuyerProfileEdit.fromJson(Map<String, dynamic> json) {
    return BuyerProfileEdit(
      nickname: json['nickname'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}

class SellerProfileEdit extends ProfileEdit {
  final String description;

  SellerProfileEdit({
    required String nickname,
    required String profileImageUrl,
    required this.description,
  }) : super(
          nickname: nickname,
          profileImageUrl: profileImageUrl,
        );

  factory SellerProfileEdit.fromJson(Map<String, dynamic> json) {
    return SellerProfileEdit(
      nickname: json['nickname'],
      profileImageUrl: json['profileImageUrl'],
      description: json['description'],
    );
  }
}
