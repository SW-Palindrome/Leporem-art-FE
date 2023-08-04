import 'package:dio/dio.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/models/item.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class MessageItemRepository {
  Future<List<MessageItem>> fetchShareMessageItem(int page,
      {String? nickname}) async {
    try {
      final response = await DioSingleton.dio.get(
        '/items/filter',
        queryParameters: {
          'nickname': nickname,
          'page': page,
        },
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<MessageItem> items =
          itemsData.map((json) => MessageItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching chat item share in repository: $e');
    }
  }

  Future<List<MessageItem>> fetchOrderMessageItem(int page,
      {String? nickname}) async {
    try {
      final response = await DioSingleton.dio.get(
        '/items/filter',
        queryParameters: {
          'nickname': nickname,
          'page': page,
        },
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];

      // 아이템 데이터를 변환하여 리스트로 생성 remainAmount가 0이면 추가하지 않음
      List<MessageItem> items = [];
      for (var i = 0; i < itemsData.length; i++) {
        if (itemsData[i]['remainAmount'] == 0) {
          continue;
        }
        items.add(MessageItem.fromJson(itemsData[i]));
      }
      return items;
    } catch (e) {
      // 에러 처리
      throw ('Error fetching chat item share in repository: $e');
    }
  }

  Future<void> orderItem(int itemId) async {
    try {
      final response = await DioSingleton.dio.post(
        '/orders/register',
        data: {
          'item_id': itemId,
        },
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      if (response.statusCode == 400) {
        if (response.data['message'] == '재고가 없습니다.') {
          throw ('재고가 없습니다.');
        } else if (response.data['meessage'] == '자신의 상품은 주문할 수 없습니다.') {
          throw ('자신의 상품은 주문할 수 없습니다.');
        }
      }
      if (response.statusCode == 201) {
        return;
      }
      throw ('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      throw ('Error ordering item in repository: $e');
    }
  }
}
