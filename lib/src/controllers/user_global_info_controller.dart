import 'package:get/get.dart';

class UserGlobalInfoController extends GetxController {
  late final int userId;
  late UserType userType;
}

enum UserType {
  member,
  guest,
}
