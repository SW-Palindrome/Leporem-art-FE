import 'package:dio/dio.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class HomeRepository {
  final Dio _dio = DioSingleton.dio;

  Future<List<Item>> fetchItems(int page) async {
    try {
      final response =
          await _dio.get('/items/buyers/main', queryParameters: {'page': page});
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<Item> items =
          itemsData.map((json) => Item.fromJson(json)).toList();
      page++;
      return items;
    } catch (e) {
      // 에러 처리
      print('Error fetching items in repository: $e');
      rethrow;
    }
  }
}

final List<Item> mockItems = [
  for (int i = 0; i < 10; i++)
    Item(
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
