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
    required this.messageList,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomId: json['chat_room_id'],
      opponentUserId: json['opponent_user_id'],
      opponentNickname: json['opponent_nickname'],
      opponentProfileImageUrl: json['opponent_profile_image'],
      lastMessageDatetime: DateTime.parse(json['last_message_datetime']),
      lastMessage: json['last_message'],
      messageList: [
        Message(messageId: '1', userId: 1, writeDatetime: DateTime.now(), isRead: true, message: '안녕하세요 너무너무좋은 밤이에요. 사실 자고싶은데 개발할 것이 산더미네요 ㅋㅋ 자고싶어요 진짜로'),
        Message(messageId: '2', userId: 7, writeDatetime: DateTime.now(), isRead: true, message: '안녕하세요'),
        Message(messageId: '3', userId: 7, writeDatetime: DateTime.now(), isRead: true, message: '왜 안녕하세요?'),
        Message(messageId: '4', userId: 1, writeDatetime: DateTime.now(), isRead: true, message: '안녕안녕 안녕하세요'),
        Message(messageId: '5', userId: 1, writeDatetime: DateTime.now(), isRead: true, message: '안녕안녕 안녕하세요'),
      ],
    );
  }
}
