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

  String toText() {
    switch (this) {
      case MessageType.text:
        return 'TEXT';
      case MessageType.image:
        return 'IMAGE';
      case MessageType.itemShare:
        return 'ITEM_SHARE';
      case MessageType.itemInquiry:
        return 'ITEM_INQUIRY';
      case MessageType.order:
        return 'ORDER';
    }
  }
}

class ItemInfo {
  int itemId;
  String thumbnailImage;
  String sellerNickname;
  String title;
  int price;

  ItemInfo({
    required this.itemId,
    required this.thumbnailImage,
    required this.sellerNickname,
    required this.title,
    required this.price,
  });
}

class Message {
  String messageUuid;
  final int userId;
  final DateTime writeDatetime;
  final bool isRead;
  final String message;
  final MessageType type;
  ItemInfo? itemInfo;

  Message({
    required this.messageUuid,
    required this.userId,
    required this.writeDatetime,
    required this.isRead,
    required this.message,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageUuid: json['uuid'],
      userId: json['user_id'],
      writeDatetime: DateTime.parse(json['write_datetime']),
      isRead: json['is_read'],
      message: json['message'],
      type: MessageType.fromText(json['type']),
    );
  }
}

class ChatRoom {
  final String chatRoomUuid;
  final int opponentUserId;
  final String opponentNickname;
  final String opponentProfileImageUrl;
  late final bool isBuyerRoom;
  bool isRegistered;
  bool hasMoreMessage = true;
  int unreadMessageCount = 0;

  List<Message> messageList = <Message>[];
  List<Message> tempMessageList = <Message>[];

  ChatRoom({
    required this.chatRoomUuid,
    required this.opponentUserId,
    required this.opponentNickname,
    required this.opponentProfileImageUrl,
    required this.messageList,
    this.isRegistered = true,
    this.unreadMessageCount = 0,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    List<Message> fetchMessageList = <Message>[];
    final message = json['last_message'];
    fetchMessageList.add(Message.fromJson(message));
    return ChatRoom(
      chatRoomUuid: json['uuid'],
      opponentUserId: json['opponent_user_id'],
      opponentNickname: json['opponent_nickname'],
      opponentProfileImageUrl: json['opponent_profile_image'],
      messageList: fetchMessageList,
      unreadMessageCount: json['unread_count'],
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
