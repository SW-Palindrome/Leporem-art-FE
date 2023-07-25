import '../models/message.dart';

class MessageRepository {
  Future<List<ChatRoom>> fetchChatRooms(int page) async {
    return [
      ChatRoom(
        nickname: '닉네임',
        profileImageUrl: 'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/309/59932b0eb046f9fa3e063b8875032edd_crop.jpeg',
        lastChatDatetime: DateTime(2023, 7, 25, 12, 14),
        lastChatMessage: '안녕하세요...',
      ),
      ChatRoom(
        nickname: '닉네임2',
        profileImageUrl: 'https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/309/59932b0eb046f9fa3e063b8875032edd_crop.jpeg',
        lastChatDatetime: DateTime(2023, 7, 20, 12, 14),
        lastChatMessage: '그렇군요 유감이네요..',
      )
    ];
  }
}