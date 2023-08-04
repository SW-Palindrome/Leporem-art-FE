import 'package:dio/dio.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

import '../configs/login_config.dart';
import '../models/message.dart';

class MessageRepository {
  Future<List<ChatRoom>> fetchBuyerChatRooms() async {
    try {
      final response = await DioSingleton.dio.get(
        '/chats/buyer',
        options: Options(
          headers: {
            "Authorization":
            "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      final data = response.data;
      List<ChatRoom> chatRoomList = [];
      for (var i = 0; i < data.length; i++) {
        ChatRoom chatRoom = ChatRoom.fromJson(data[i]);
        chatRoom.isBuyerRoom = true;
        chatRoomList.add(chatRoom);
      }
      return chatRoomList;
    }
    catch (e) {
      // 에러 처리
      throw ('Error fetching chat rooms in repository: $e');
    }
  }

  Future<List<ChatRoom>> fetchSellerChatRooms() async {
    try {
      final response = await DioSingleton.dio.get(
        '/chats/seller',
        options: Options(
          headers: {
            "Authorization":
            "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      if (response.statusCode == 403) {
        return [];
      }
      final data = response.data;
      List<ChatRoom> chatRoomList = [];
      for (var i = 0; i < data.length; i++) {
        ChatRoom chatRoom = ChatRoom.fromJson(data[i]);
        chatRoom.isBuyerRoom = false;
        chatRoomList.add(chatRoom);
      }
      return chatRoomList;
    }
    catch (e) {
      // 에러 처리
      throw ('Error fetching chat rooms in repository: $e');
    }
  }
}
