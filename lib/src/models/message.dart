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
  final DateTime lastMessageDatetime;
  final String lastMessage;

  List<Message> messageList = <Message>[];
  List<Message> tempMessageList = <Message>[];

  ChatRoom({
    required this.chatRoomId,
    required this.opponentUserId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.lastMessageDatetime,
    required this.lastMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomId: json['chat_room_id'],
      opponentUserId: json['opponent_user_id'],
      opponentNickname: json['opponent_nickname'],
      opponentProfileImageUrl: json['opponent_profile_image'],
      lastMessageDatetime: DateTime.parse(json['last_message_datetime']),
      lastMessage: json['last_message'],
    );
  }
}
