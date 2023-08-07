import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item_detail.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class ItemDetailRepository {
  Future<ItemDetail> fetchItemDetail(int itemID) async {
    try {
      // API 요청
      final response = await DioSingleton.dio.get(
        '/items/detail/buyer',
        queryParameters: {'item_id': itemID},
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      final data = response.data['detail'];
      // API 응답을 Item 모델로 변환
      final ItemDetail itemDetail = ItemDetail.fromJson(data);

      return itemDetail;
    } catch (e) {
      // 에러 처리
      print('Error fetching item detail in repository: $e');
      // 목업 데이터 반환
      return mockItemDetail;
    }
  }
}

final mockItemDetail = ItemDetail(
  id: 1,
  profileImage:
      'https://dimg.donga.com/wps/NEWS/IMAGE/2021/01/17/104953245.2.jpg',
  nickname: '불타는 효자',
  temperature: 95,
  title: '구름이 이쁜 멋진 상품',
  description:
      '상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명\n상품 설명',
  price: 10000,
  category: ['태그 1', '태그 2'],
  currentAmount: 5,
  thumbnailImage:
      'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
  images: [
    'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
    'https://thumbnail6.coupangcdn.com/thumbnails/remote/292x292ex/image/rs_quotation_api/ytqc8cje/b0bc8fe9d933474ba5824e2c6b08b935.jpg',
    'https://thumbnail9.coupangcdn.com/thumbnails/remote/292x292ex/image/retail/images/2020/10/27/12/7/6a8098ac-d89a-4846-aff4-c9bd6f43d507.jpg',
  ],
  shorts:
      'https://leporem-art-fe-test.s3.ap-northeast-2.amazonaws.com/test.mp4',
  isLiked: true,
  depth: '1.02',
  height: '13.52',
  width: '100',
);
