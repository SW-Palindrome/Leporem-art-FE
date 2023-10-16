import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../configs/login_config.dart';
import '../controllers/message_controller.dart';
import '../models/message.dart';


class ChattingSocketSingleton {
  late IO.Socket _socket;
  bool isAuthenticated = false;

  static final ChattingSocketSingleton _instance =
      ChattingSocketSingleton._internal();

  factory ChattingSocketSingleton() {
    return _instance;
  }

  ChattingSocketSingleton._internal() {
    _socket = IO.io(dotenv.get('CHATTING_SERVER_URL'), OptionBuilder()
        .setTransports(['websocket'])
        .build());
    _socket.onConnect((_) {
      _authenticate();
    });
    _socket.on('receive_message', (data) {
      MessageController messageController = Get.find<MessageController>();
      messageController.receiveMessage(
          data['chat_room_uuid'],
          data['message_uuid'],
          data['message'],
          MessageType.fromText(data['message_type']),
      );
    });
    _socket.on('message_registered', (data) {
      MessageController messageController = Get.find<MessageController>();
      messageController.registerMessage(data['chat_room_uuid'], data['message_uuid']);
    });
    _socket.on('receive_chat_room_create', (data) {
      MessageController messageController = Get.find<MessageController>();
      // TODO: 채팅 방 생성 시 채팅서버에서 데이터 처리
      messageController.fetch();
    });
    _socket.on('chat_room_registered', (data) {
      MessageController messageController = Get.find<MessageController>();
      messageController.getChatRoom(data['chat_room_uuid']).isRegistered = true;
      messageController.chatRoomList.refresh();
      messageController.sendTempMessage(data['chat_room_uuid']);
    });
  }

  _authenticate() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    _socket.emit('authenticate', {
      'access_token': accessToken,
    });
    isAuthenticated = true;
  }

  sendMessage(
      String chatRoomUuid,
      int opponentUserId,
      String message,
      String messageUuid,
      MessageType messageType,
  ) async {
    if (!isAuthenticated) {
      await _authenticate();
    }
    _socket.emit('send_message', {
      'chat_room_uuid': chatRoomUuid,
      'opponent_user_id': opponentUserId,
      'message': message,
      'message_uuid': messageUuid,
      'message_type': messageType.toText(),
    });
  }

  createChatRoom(
    String chatRoomUuid,
    int sellerId,
    String message,
    String messageUuid,
    int opponentUserId,
    MessageType messageType,
  ) async {
    if (!isAuthenticated) {
      await _authenticate();
    }
    _socket.emit('create_chat_room', {
      'chat_room_uuid': chatRoomUuid,
      'seller_id': sellerId,
      'message': message,
      'message_uuid': messageUuid,
      'opponent_user_id': opponentUserId,
      'message_type': messageType.toText(),
    });
  }
}
