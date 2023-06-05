import 'dart:developer';

import 'package:bhagavad_gita_flutter/notification/push_notification/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Messaging {
  static void showMessage() {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.getInitialMessage().then((message) {
      if (message != null && message.data['channel_id'] != null) {}
    });

    /// forground work
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message?.data['channel_id'] != null) {
        PushNotificationService.display(message!);
      }
    });

    // When the app is in background but open and user taps
    // on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['channel_id'] != null) {
        PushNotificationService.display(message);
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("bg message");
  if (message.data['channel_id'] != null) {
    PushNotificationService.display(message);
  }
}
