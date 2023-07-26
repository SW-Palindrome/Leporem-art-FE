class ChatRoom {
  final String nickname;
  final String profileImageUrl;
  final DateTime lastChatDatetime;
  final String lastChatMessage;

  ChatRoom({
    required this.nickname,
    required this.profileImageUrl,
    required this.lastChatDatetime,
    required this.lastChatMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        nickname: json['nickname'],
        profileImageUrl: json['profile_image'],
        lastChatDatetime: json['last_chat_datetime'],
        lastChatMessage: json['last_chat_message']
    );
  }
}