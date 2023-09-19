import 'package:dio/dio.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/login_config.dart';
import '../models/message.dart';

class MessageRepository {
  Future<List<ChatRoom>> fetchBuyerChatRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/chats/buyer',
        queryParameters: {
          'only_last_message': true,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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
    } catch (e) {
      // 에러 처리
      throw ('Error fetching chat rooms in repository: $e');
    }
  }

  Future<List<ChatRoom>> fetchSellerChatRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await DioSingleton.dio.get(
        '/chats/seller',
        queryParameters: {
          'only_last_message': true,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
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
    } catch (e) {
      // 에러 처리
      throw ('Error fetching chat rooms in repository: $e');
    }
  }

  Future<List<Message>> fetchChatRoomMessages(String chatRoomUuid, String? messageUuid) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await DioSingleton.dio.get(
      '/chats/chat-rooms/$chatRoomUuid/messages',
      queryParameters: {
        'message_uuid': messageUuid
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    final data = response.data['results'];
    List<Message> messageList = [];
    for (var i = 0; i < data.length; i++) {
      Message message = Message.fromJson(data[i]);
      messageList.add(message);
    }
    return messageList;
  }
}
