import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';
import '../provider/api.dart';
import '../provider/dio.dart';

class MessageRepository {
  final ApiClient apiClient;
  MessageRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<ChatRoom>> fetchBuyerChatRooms() async {
    return apiClient.fetchBuyerChatRooms();
  }

  Future<List<ChatRoom>> fetchSellerChatRooms() async {
    return apiClient.fetchSellerChatRooms();
  }

  Future<List<Message>> fetchChatRoomMessages(
      String chatRoomUuid, String? messageUuid) async {
    return apiClient.fetchChatRoomMessages(chatRoomUuid, messageUuid);
  }

  Future<void> readChatRoomMessages(ChatRoom chatRoom, Message message) async {
    return apiClient.readChatRoomMessages(chatRoom, message);
  }
}
