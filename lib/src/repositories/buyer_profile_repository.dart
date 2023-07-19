import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/buyer_profile.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class BuyerProfileRepository {
  final Dio _dio = DioSingleton.dio;

  Future<BuyerProfile> fetchBuyerProfile() async {
    try {
      String? idToken = await getIDToken();
      // API 요청
      final response = await _dio.get(
        '/buyers/my',
        options: Options(
          headers: {"Authorization": "Palindrome $idToken"},
        ),
      );
      final data = response.data;
      final BuyerProfile buyerProfile = BuyerProfile.fromJson(data);
      return buyerProfile;
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer profile in repository: $e');
      // 목업 데이터 반환
      return mockBuyerProfile;
    }
  }
}

final mockBuyerProfile = BuyerProfile(
  nickname: '불건전한 소환사명',
  profileImageUrl:
      'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
  isSeller: true,
);
