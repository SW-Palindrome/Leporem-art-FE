class Message {
  String messageId;
  final int userId;
  final DateTime writeDatetime;
  final bool isRead;
  final String message;

  Message({
    required this.messageId,
    required this.userId,
    required this.writeDatetime,
    required this.isRead,
    required this.message,
  });
}

class ChatRoom {
  final int chatRoomId;
  final int opponentUserId;
  final String opponentNickname;
  final String opponentProfileImageUrl;
  late final bool isBuyerRoom;

  List<Message> messageList = <Message>[];
  List<Message> tempMessageList = <Message>[];

  ChatRoom({
    required this.chatRoomId,
    required this.opponentUserId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.messageList,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    List<Message> fetchMessageList = <Message>[];
    for (final message in json['message_list']) {
      fetchMessageList.add(Message(
        messageId: message['message_id'].toString(),
        userId: message['user_id'],
        writeDatetime: DateTime.parse(message['write_datetime']),
        isRead: message['is_read'],
        message: message['text'],
      ));
    }
    return ChatRoom(
      chatRoomId: json['chat_room_id'],
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
