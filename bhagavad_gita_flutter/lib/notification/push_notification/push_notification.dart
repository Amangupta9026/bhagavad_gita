// ignore_for_file: file_names

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _notificationsPlugin.initialize(initializationSettings);
    // _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async{
    //   if(route != null ){
    //     Navigator.of(context).pushNamed(route);
    //   }
    // } );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
        'QWise',
        'E-Learning',
        channelDescription: 'Start | Learning',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        onlyAlertOnce: true,
        timeoutAfter: 30,
     //   sound: AndroidNotificationSound.,
      ));
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['route'],
      );
    } catch (error) {
      log("$error");
      // FirebaseCrashlytics.instance.recordError(
      //   error,
      //   StackTrace.current,
      //   reason: 'Error in display method of PushNotificationService file.',
      // );
    }
  }
}
