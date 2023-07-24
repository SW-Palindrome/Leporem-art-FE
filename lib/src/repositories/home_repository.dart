import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class HomeRepository {
  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(int page) async {
    try {
      final response = await DioSingleton.dio
          .get('/items/buyers/main', queryParameters: {'page': page});
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      page++;
      return items;
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer home items in repository: $e');
      return mockBuyerHomeItems;
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
      page++;
      return items;
    } catch (e) {
      // 에러 처리
      print('Error fetching buyer home items in repository: $e');
      return mockSellerHomeItems;
    }
  }
}

final List<BuyerHomeItem> mockBuyerHomeItems = [
  BuyerHomeItem(
    id: 1,
    name: '상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품상품',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  for (int i = 0; i < 10; i++)
    BuyerHomeItem(
      id: 1,
      name: '상품 1',
      creator: '제작자 1',
      price: 10000,
      thumbnailUrl:
          'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
      likes: 50,
      isLiked: true,
    )
];

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
