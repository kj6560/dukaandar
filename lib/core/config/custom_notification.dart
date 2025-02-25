import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  // constructor
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      'pushnotificationapp',
      'pushnotificationapp',
      channelDescription: 'pushnotificationapp',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  // static const iOS = null;
  // static const platform = NotificationDetails(android: android, iOS: iOS);

  // init
  static init() async {
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(
          'app_icon',
        ),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,

          // onDidReceiveLocalNotification: (id, title, body, payload) async {
          //   if (payload != null) {
          //     print('IOS setting here');
          //     // _handlePayload(payload);
          //   }
          // },
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.notificationResponseType ==
            NotificationResponseType.selectedNotification) {
          String? payload = response.payload;
          if (payload != null) {
            print('Payload from tap: $payload');
            _handleNotificationNavigation(response.payload);
          }
        }
      },
    );
  }

  // show
  static show({
    required String title,
    required String body,
    String? payload,
  }) async {
    // random id
    int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static void _handleNotificationNavigation(var data) {
    print('notification response: $data');
// Step 1: Decode the outer JSON
    Map<String, dynamic> outerDecoded = jsonDecode(data);

    // Step 2: Extract the payload and decode it again
    String innerPayload = outerDecoded['payload'];
    Map<String, dynamic> innerDecoded = jsonDecode(innerPayload);
    print('Outer Decoded: $outerDecoded');
    print('Inner Decoded: $innerDecoded');
    if (innerDecoded.containsKey('type')) {
      int type = int.parse(innerDecoded['type'].toString());
      if (type == 1) {
        //TODO: handle nav to chat
        // Get.toNamed('/all_chats');
      } else if (type == 2) {
        print('goto notif screen');
        // Navigate to Notification Screen
        //TODO: handle nav to notification

        // Get.toNamed('/notifications');
      } else {
        print("Unhandled notification type: $type");
      }
    } else {
      print("Payload not found in notification data");
      //TODO: handle nav to notification

      // Get.toNamed('/notifications');
    }
  }
}
