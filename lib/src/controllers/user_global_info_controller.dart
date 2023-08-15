import 'package:get/get.dart';

class UserGlobalInfoController extends GetxController {
  late int userId;
  late UserType userType;
  late String nickname;
  late bool isSeller;
}

enum UserType {
  member,
  guest,
}
