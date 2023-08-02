class ProfileEdit {
  final String nickname;
  final String profileImage;

  ProfileEdit({
    required this.nickname,
    required this.profileImage,
  });
}

class BuyerProfileEdit extends ProfileEdit {
  BuyerProfileEdit({
    required String nickname,
    required String profileImage,
  }) : super(
          nickname: nickname,
          profileImage: profileImage,
        );
}

class SellerProfileEdit extends ProfileEdit {
  final String description;

  SellerProfileEdit({
    required String nickname,
    required String profileImage,
    required this.description,
  }) : super(
          nickname: nickname,
          profileImage: profileImage,
        );
}
