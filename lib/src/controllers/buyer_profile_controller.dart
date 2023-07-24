import 'package:get/get.dart';
import 'package:leporemart/src/models/profile.dart';
import 'package:leporemart/src/repositories/profile_repository.dart';

class BuyerProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  BuyerProfile buyerProfile = BuyerProfile(
    nickname: '불건전한소환사명',
    profileImageUrl:
        'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
    isSeller: true,
  );

  @override
  void onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      buyerProfile = await _profileRepository.fetchBuyerProfile();
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
