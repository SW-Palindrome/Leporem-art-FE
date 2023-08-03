class ChatRoom {
  final int chatRoomId;
  final String opponentNickname;
  final String opponentProfileImageUrl;
  final DateTime lastMessageDatetime;
  final String lastMessage;

  ChatRoom({
    required this.chatRoomId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.lastMessageDatetime,
    required this.lastMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatRoomId: json['chat_room_id'],
      opponentNickname: json['opponent_nickname'],
      opponentProfileImageUrl: json['opponent_profile_image'],
      lastMessageDatetime: DateTime.parse(json['last_message_datetime']),
      lastMessage: json['last_message'],
    );
  }
}
