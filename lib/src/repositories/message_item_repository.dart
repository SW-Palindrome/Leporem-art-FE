import 'package:leporemart/src/models/item.dart';

class MessageItemRepository {
  Future<List<MessageItem>> fetchShareMessageItem() {
    try {
      return Future.value(
        [
          MessageItem(
            id: 1,
            title: '아름다운 도자기',
            nickname: '홍준식',
            price: 10000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ), //사진은 그대로하고 제목과 닉네임 가격은 다르게 해서 3개정도 만들어서 보여주기
          MessageItem(
            id: 2,
            title: '구름을 담은 컵',
            nickname: '홍준식',
            price: 20000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 3,
            title: '아름다운 도자기',
            nickname: '홍준식',
            price: 10000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 4,
            title: '구름을 담은 컵',
            nickname: '홍준식',
            price: 20000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 5,
            title: '아름다운 도자기',
            nickname: '홍준식',
            price: 10000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 6,
            title: '구름을 담은 컵',
            nickname: '홍준식',
            price: 20000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 7,
            title: '아름다운 도자기',
            nickname: '홍준식',
            price: 10000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 8,
            title: '구름을 담은 컵',
            nickname: '홍준식',
            price: 20000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 9,
            title: '아름다운 도자기',
            nickname: '홍준식',
            price: 10000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
          MessageItem(
            id: 10,
            title: '구름을 담은 컵',
            nickname: '홍준식',
            price: 20000,
            thumbnailImage:
                'https://leporem-art-media-dev.s3.amazonaws.com/items/item_image/1e6a2881-fb08-41f5-85ef-ed448b331697.jpg',
          ),
        ],
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
