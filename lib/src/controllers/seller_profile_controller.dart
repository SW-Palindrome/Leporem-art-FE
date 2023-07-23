import 'package:get/get.dart';
import 'package:leporemart/src/models/seller_profile.dart';
import 'package:leporemart/src/repositories/seller_profile_repository.dart';

class SellerProfileController extends GetxController {
  final SellerProfileRepository _sellerProfileRepository =
      SellerProfileRepository();
  SellerProfile sellerProfile = SellerProfile(
    nickname: '불건전한 소환사명',
    profileImageUrl:
        'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
    itemCount: 22,
    temperature: 36.5,
    description: '안녕하세요. 불건전한 소환사명입니다.',
  );

  @override
  void onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    try {
      sellerProfile = await _sellerProfileRepository.fetchSellerProfile();
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile: $e');
      // 목업 데이터 사용 또는 에러 처리 로직 추가
    }
  }
}
