class Message {
  String messageUuid;
  final int userId;
  final DateTime writeDatetime;
  final bool isRead;
  final String message;

  Message({
    required this.messageUuid,
    required this.userId,
    required this.writeDatetime,
    required this.isRead,
    required this.message,
  });
}

class ChatRoom {
  final String chatRoomUuid;
  final int opponentUserId;
  final String opponentNickname;
  final String opponentProfileImageUrl;
  late final bool isBuyerRoom;

  List<Message> messageList = <Message>[];
  List<Message> tempMessageList = <Message>[];

  ChatRoom({
    required this.chatRoomUuid,
    required this.opponentUserId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.messageList,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    List<Message> fetchMessageList = <Message>[];
    for (final message in json['message_list']) {
      fetchMessageList.add(Message(
        messageUuid: message['uuid'],
        userId: message['user_id'],
        writeDatetime: DateTime.parse(message['write_datetime']),
        isRead: message['is_read'],
        message: message['text'],
      ));
    }
    return ChatRoom(
      chatRoomUuid: json['uuid'],
      opponentUserId: json['opponent_user_id'],
      opponentNickname: json['opponent_nickname'],
      opponentProfileImageUrl: json['opponent_profile_image'],
      messageList: fetchMessageList,
    );
  }

  DateTime get lastMessageDatetime {
    return messageList.last.writeDatetime;
  }

  String get lastMessage {
    return messageList.last.message;
  }
}
