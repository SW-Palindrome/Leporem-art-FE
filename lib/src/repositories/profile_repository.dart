import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/profile.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  Future<BuyerProfile> fetchBuyerProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/buyers/info',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
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

  Future<SellerProfile> fetchSellerProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/sellers/info',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      final SellerProfile sellerProfile = SellerProfile.fromJson(data);
      return sellerProfile;
    } catch (e) {
      // 에러 처리
      print('Error fetching seller profile in repository: $e');
      // 목업 데이터 반환
      return mockSellerProfile;
    }
  }

  Future<SellerProfile> fetchCreatorProfile(String nickname) async {
    try {
      final response = await DioSingleton.dio.get(
        '/sellers/info/$nickname',
      );
      final data = response.data;
      final SellerProfile sellerProfile = SellerProfile.fromJson(data);
      return sellerProfile;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching creator profile in repository: $e');
    }
  }
}

final mockBuyerProfile = BuyerProfile(
  nickname: '불건전한 소환사명',
  profileImage:
      'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
  isSeller: true,
);

final mockSellerProfile = SellerProfile(
  nickname: '불건전한 소환사명',
  profileImageUrl:
      'http://www.chemicalnews.co.kr/news/photo/202106/3636_10174_4958.jpg',
  itemCount: 22,
  totalTransaction: 33,
  temperature: 36.5,
  description: '안녕하세요. 불건전한 소환사명입니다.',
  retentionRate: 84,
);
