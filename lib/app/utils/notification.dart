import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/firebase_options.dart';
import '../data/models/notice.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> fcmSetting() async {
  // firebase core 기능 사용을 위한 필수 initializing
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (Platform.isAndroid) {
    // foreground에서의 푸시 알림 표시를 위한 알림 중요도 설정 (안드로이드)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'leporemart_notification', 'leporemart_notification',
        description: '공예쁨 알림입니다.', importance: Importance.max);

    // foreground 에서의 푸시 알림 표시를 위한 local notifications 설정
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // foreground 푸시 알림 핸들링
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification?.title,
            notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@drawable/ic_stat_notiicon',
              ),
            ));

        print('Message also contained a notification: ${message.notification}');
        Notice notice = Notice(
          date:
              "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
          title: message.notification!.title!,
          content: message.notification!.body!,
        );
        print(notice);
        final prefs = await SharedPreferences.getInstance();
        final noticesJson = prefs.getString('notices') ?? '[]';
        final List<dynamic> noticesList = json.decode(noticesJson);
        noticesList.add(notice);
        final encode = jsonEncode(noticesList);
        await prefs.setString("notices", encode);
      }
    });
  } else if (Platform.isIOS) {
    // foreground 푸시 알림 핸들링
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message != null) {
        if (message.notification != null) {
          // foreground 메시지를 받으면 알림을 띄운다.
          print('onMessage: ${message.notification!.title}');
          print(message.notification!.title);
          print(message.notification!.body);
          print(message.data["click_action"]);
          Notice notice = Notice(
            date:
                "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
            title: message.notification!.title!,
            content: message.notification!.body!,
          );
          final prefs = await SharedPreferences.getInstance();
          final noticesJson = prefs.getString('notices') ?? '[]';
          final List<dynamic> noticesList = json.decode(noticesJson);
          print(noticesList.length);
          noticesList.add(notice);
          final encode = jsonEncode(noticesList);
          await prefs.setString("notices", encode);
        }
      }
    });
  }

  // background 푸시 알림 핸들링
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
    if (message != null) {
      if (message.notification != null) {
        print('onMessageOpenedApp: ${message.notification!.title}');
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data["click_action"]);
        Notice notice = Notice(
          date:
              "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
          title: message.notification!.title!,
          content: message.notification!.body!,
        );
        final prefs = await SharedPreferences.getInstance();
        final noticesJson = prefs.getString('notices') ?? '[]';
        final List<dynamic> noticesList = json.decode(noticesJson);
        noticesList.add(notice);
        final encode = jsonEncode(noticesList);
        await prefs.setString("notices", encode);
      }
    }
  });

  // 앱이 종료된 상태에서 푸시 알림 핸들링
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    if (message != null) {
      if (message.notification != null) {
        print('getInitialMessage: ${message.notification!.title}');
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data["click_action"]);
        Notice notice = Notice(
          date:
              "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
          title: message.notification!.title!,
          content: message.notification!.body!,
        );
        final prefs = await SharedPreferences.getInstance();
        final noticesJson = prefs.getString('notices') ?? '[]';
        final List<dynamic> noticesList = json.decode(noticesJson);
        noticesList.add(notice);
        final encode = jsonEncode(noticesList);
        await prefs.setString("notices", encode);
      }
    }
  });
}
