import 'package:get/get.dart';
import 'package:leporemart/src/models/profile.dart';
import 'package:leporemart/src/repositories/profile_repository.dart';

class SellerProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  SellerProfile sellerProfile = SellerProfile(
    nickname: '불건전한소환사명',
    profileImageUrl:
        'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
    itemCount: 22,
    temperature: 36.5,
    description: '안녕하세요. 불건전한소환사명입니다.',
  );

  @override
  void onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      sellerProfile = await _profileRepository.fetchSellerProfile();
    } catch (e) {
      // 에러 처리
      print('Error fetching seller profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
