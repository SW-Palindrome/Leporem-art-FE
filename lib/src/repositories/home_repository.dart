import 'package:dio/dio.dart';
import 'package:leporemart/src/models/item.dart';

class HomeRepository {
  final Dio _dio = Dio();

  Future<List<Item>> fetchItems() async {
    try {
      // API 요청
      final response = await _dio.get('https://api.example.com/items');
      final data = response.data;

      // API 응답을 Item 모델 리스트로 변환
      final List<Item> items = (data['products'] as List)
          .map((json) => Item.fromJson(json))
          .toList();

      return items;
    } catch (e) {
      // 에러 처리
      print('Error fetching items in repository: $e');
      // 목업 데이터 반환
      return mockItems;
    }
  }
}

final List<Item> mockItems = [
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
  Item(
    id: 1,
    name: '상품 1',
    creator: '제작자 1',
    price: 10000,
    thumbnailUrl:
        'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    likes: 50,
    isLiked: true,
  ),
  Item(
    id: 2,
    name: '상품 2',
    creator: '제작자 2',
    price: 20000,
    thumbnailUrl:
        'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    likes: 30,
    isLiked: false,
  ),
];
