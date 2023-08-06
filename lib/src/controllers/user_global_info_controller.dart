import 'package:get/get.dart';

class UserGlobalInfoController extends GetxController {
  late final int userId;
  late UserType userType;
  late String nickname;
}

enum UserType {
  member,
  guest,
}
