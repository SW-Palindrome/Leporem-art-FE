import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/notice.dart';

class LocalClient {
  Future<List<Notice>> getNotices() async {
    List<Notice> notices = [];
    final pref = await SharedPreferences.getInstance();
    var data = pref.getString("notices");

    if (data != null) {
      final decode = jsonDecode(data);
      if (decode is List<dynamic>) {
        for (final e in decode) {
          notices.add(Notice.fromJson(e));
        }
      }
    }
    return notices;
  }

  Future<void> removeNotices() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("notices");
  }
}
