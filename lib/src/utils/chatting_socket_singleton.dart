import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../configs/login_config.dart';


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
      // TODO: 컨트롤러에 데이터 업데이트
      print(data);
    });
  }

  _authenticate() async {
    _socket.emit('authenticate', {
      'id_token': await getOAuthToken().then((value) => value!.idToken),
    });
    isAuthenticated = true;
  }

  sendMessage(chatRoomId, opponentUserId, message) async {
    if (!isAuthenticated) {
      await _authenticate();
    }
    _socket.emit('send_message', {
      'chat_room_id': chatRoomId,
      'opponent_user_id': opponentUserId,
      'message': message,
    });
  }
}
