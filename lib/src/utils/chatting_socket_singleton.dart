import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../configs/login_config.dart';
import '../controllers/message_controller.dart';


class ChattingSocketSingleton {
  late IO.Socket _socket;
  bool isAuthenticated = false;

  static final ChattingSocketSingleton _instance =
      ChattingSocketSingleton._internal();

  factory ChattingSocketSingleton() {
    return _instance;
  }

  ChattingSocketSingleton._internal() {
    _socket = IO.io('http://13.125.126.42', OptionBuilder()
        .setTransports(['websocket'])
        .build());
    _socket.onConnect((_) {
      _authenticate();
    });
    _socket.on('receive_message', (data) {
      MessageController buyerMessageController = Get.find<MessageController>();
      buyerMessageController.receiveMessage(data['chat_room_uuid'], data['message_uuid'], data['message']);
    });
    _socket.on('message_registered', (data) {
      MessageController buyerMessageController = Get.find<MessageController>();
      buyerMessageController.registerMessage(data['chat_room_uuid'], data['message_uuid']);
    });
  }

  _authenticate() async {
    _socket.emit('authenticate', {
      'id_token': await getOAuthToken().then((value) => value!.idToken),
    });
    isAuthenticated = true;
  }

  sendMessage(chatRoomUuid, opponentUserId, message, messageUuid) async {
    if (!isAuthenticated) {
      await _authenticate();
    }
    _socket.emit('send_message', {
      'chat_room_uuid': chatRoomUuid,
      'opponent_user_id': opponentUserId,
      'message': message,
      'message_uuid': messageUuid,
    });
  }
}
