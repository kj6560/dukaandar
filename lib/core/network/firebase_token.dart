import 'dart:developer';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFirebaseToken() async {
  try {
    String? fcmToken;

    if (Platform.isIOS) {
      // Get the APNS token for iOS devices
      String? fcmAPNSToken = await FirebaseMessaging.instance.getAPNSToken();
      if (fcmAPNSToken != null) {
        log('APNSToken: $fcmAPNSToken');
      }
      fcmToken = await FirebaseMessaging.instance.getToken();
    } else if (Platform.isAndroid) {
      fcmToken = await FirebaseMessaging.instance.getToken();
    }
    if (fcmToken != null) {
      print('FCM Token: $fcmToken');
      return fcmToken;
    } else {
      print('Failed to get FCM token');
      return "";
    }
  } catch (e) {
    print('Error fetching Firebase token: $e');
    return "";
  }
}
