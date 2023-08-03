import 'package:dio/dio.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

import '../configs/login_config.dart';
import '../models/message.dart';

class MessageRepository {
  Future<List<ChatRoom>> fetchChatRooms() async {
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
        chatRoomList.add(ChatRoom.fromJson(data[i]));
      }
      return chatRoomList;
    }
    catch (e) {
      // 에러 처리
      throw ('Error fetching chat rooms in repository: $e');
    }
  }
}
