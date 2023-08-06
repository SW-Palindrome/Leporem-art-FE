enum MessageType {
  text,
  image,
  itemShare,
  itemInquiry,
  order;

  factory MessageType.fromText(String text) {
    switch (text) {
      case 'TEXT':
        return MessageType.text;
      case 'IMAGE':
        return MessageType.image;
      case 'ITEM_SHARE':
        return MessageType.itemShare;
      case 'ITEM_INQUIRY':
        return MessageType.itemInquiry;
      case 'ORDER':
        return MessageType.order;
      default:
        throw Exception('Unknown MessageType: $text');
    }
  }
}

class Message {
  String messageUuid;
  final int userId;
  final DateTime writeDatetime;
  final bool isRead;
  final String message;
  final MessageType type;

  Message({
    required this.messageUuid,
    required this.userId,
    required this.writeDatetime,
    required this.isRead,
    required this.message,
    required this.type,
  });
}

class ChatRoom {
  final String chatRoomUuid;
  final int opponentUserId;
  final String opponentNickname;
  final String opponentProfileImageUrl;
  late final bool isBuyerRoom;
  bool isRegistered;

  List<Message> messageList = <Message>[];
  List<Message> tempMessageList = <Message>[];

  ChatRoom({
    required this.chatRoomUuid,
    required this.opponentUserId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.messageList,
    this.isRegistered = true,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    List<Message> fetchMessageList = <Message>[];
    for (final message in json['message_list']) {
      fetchMessageList.add(Message(
        messageUuid: message['uuid'],
        userId: message['user_id'],
        writeDatetime: DateTime.parse(message['write_datetime']),
        isRead: message['is_read'],
        message: message['message'],
        type: MessageType.fromText(message['type']),
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

  DateTime? get lastMessageDatetime {
    if (messageList.isEmpty) {
      return null;
    }
    return messageList.last.writeDatetime;
  }

  String get lastMessage {
    if (messageList.isEmpty) {
      return '';
    }
    if (messageList.last.type == MessageType.image) {
      return '[사진]';
    }
    if (messageList.last.type == MessageType.itemShare) {
      return '[작품 공유]';
    }
    if (messageList.last.type == MessageType.itemInquiry) {
      return '[작품 문의]';
    }
    if (messageList.last.type == MessageType.order) {
      return '[주문]';
    }
    return messageList.last.message;
  }
}
