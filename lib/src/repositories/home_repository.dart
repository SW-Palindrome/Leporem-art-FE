import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class HomeRepository {
  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
  }) async {
    try {
      print(
          '현재 페이지: $page\n현재 검색어 : $keyword\n현재 카테고리: $category\n현재 정렬: $ordering\n현재 가격: $price');
      final response =
          await DioSingleton.dio.get('/items/filter', queryParameters: {
        'page': page,
        'search': keyword,
        'ordering': ordering,
        'category': category,
        'price': price,
      });
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];
      print('총 길이: ${itemsData.length}');
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer home items in repository: $e');
    }
  }

  Future<List<SellerHomeItem>> fetchSellerHomeItems(int page) async {
    try {
      final response = await DioSingleton.dio
          .get('/items/sellers/main', queryParameters: {'page': page});
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<SellerHomeItem> items =
          itemsData.map((json) => SellerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching buyer home items in repository: $e');
    }
  }
}

final List<BuyerHomeItem> mockBuyerHomeItems = [];

final List<SellerHomeItem> mockSellerHomeItems = [
  for (int i = 0; i < 10; i++)
    SellerHomeItem(
      id: 1,
      name: '상품상품상품상품상품',
      creator: '제작자 1',
      price: 10000,
      thumbnailUrl:
          'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
      likes: 50,
      messages: 10,
      timeAgo: '10분 전',
      star: 4.5,
      remainAmount: 5,
      isAuction: false,
    ),
];
