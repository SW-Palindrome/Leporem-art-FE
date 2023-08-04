import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../configs/login_config.dart';
import '../controllers/buyer_message_controller.dart';


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
      BuyerMessageController buyerMessageController = Get.find<BuyerMessageController>();
      buyerMessageController.receiveMessage(data['chat_room_id'], data['message_id'], data['message']);
    });
    _socket.on('message_registered', (data) {
      BuyerMessageController buyerMessageController = Get.find<BuyerMessageController>();
      buyerMessageController.registerMessage(data['chat_room_id'], data['message_temp_id'], data['message_id']);
    });
  }

  _authenticate() async {
    _socket.emit('authenticate', {
      'id_token': await getOAuthToken().then((value) => value!.idToken),
    });
    isAuthenticated = true;
  }

  sendMessage(chatRoomId, opponentUserId, message, messageId) async {
    if (!isAuthenticated) {
      await _authenticate();
    }
    _socket.emit('send_message', {
      'chat_room_id': chatRoomId,
      'opponent_user_id': opponentUserId,
      'message': message,
      'message_id': messageId,
    });
  }
}
