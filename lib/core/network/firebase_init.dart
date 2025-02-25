import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../config/custom_notification.dart';
import 'firebase_token.dart';

firebaseInit() async {
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  String? fcmToken = await getFirebaseToken();
  print('fcmtoken=>' + fcmToken.toString());

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  try {
    messaging.subscribeToTopic('all');
  } catch (e) {}

// Request permission to receive notifications
  messaging.requestPermission();

// Listen for notifications while the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log('Got a message whilst in the foreground!');
    log('Message data:\n${message.data}');
    if (message.notification != null) {
      log('Message also contained a notification:\n${message.notification?.toMap()}');
    }

    CustomNotification.show(
      title: message.notification?.title ?? 'N/A',
      body: message.notification?.body ?? 'N/A',
      payload: jsonEncode(message.data),
    );
  });

// Listen for notifications click when the app is in the background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        CustomNotification.show(
          title: message.notification?.title ?? 'N/A',
          body: message.notification?.body ?? 'N/A',
          payload: jsonEncode(message.data),
        );
      }
    });
  });

// Handle notifications when the app is in the background or terminated
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point') // Required for background execution
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  String? fcmToken = await getFirebaseToken();
  print('fcmtoken=>' + fcmToken.toString());
  log('Got a message whilst in the background!');
  // Log and handle background notification
  print('Handling a background message: ${message.messageId}');
  log('Message data:\n${message.data}');
  if (message.notification != null) {
    log('Message also contained a notification:\n${message.notification?.toMap()}');
    // CustomNotification.show(
    //   title: message.notification?.title ?? 'N/A',
    //   body: message.notification?.body ?? 'N/A',
    //   payload: jsonEncode(message.data),
    // );
  }
}
