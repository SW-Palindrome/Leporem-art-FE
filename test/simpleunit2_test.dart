import 'package:flutter_test/flutter_test.dart';

int add(int x, int y) {
  return (x + y);
}

void main() {
  group('add func test', () {
    test('test 1', () {
      expect(add(20, 30), 50);
    });
    // test('test 2', () {
    //   expect(add(20, 30), 60);
    // });
  });
}
