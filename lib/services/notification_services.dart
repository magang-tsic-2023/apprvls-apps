import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationServices {
  int id = 0;

  Future<void> showNotification({String? title, String? body}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Notifikasi 1', 'Notifikasi dokumen baru',
            channelDescription: 'Notifikasi untuk dokumen yang baru di upload',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, title, body, notificationDetails,
        payload: 'payload kosong');
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
