import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final notificationNotifierProvider =
    AsyncNotifierProvider<AdminNotificationSendNotifier, AdminNotificationMode>(
        () {
  return AdminNotificationSendNotifier();
});

class AdminNotificationMode {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
}

class AdminNotificationSendNotifier
    extends AsyncNotifier<AdminNotificationMode> {
  final AdminNotificationMode _adminNotificationMode = AdminNotificationMode();

  void clearTextFields() {
    _adminNotificationMode.titleController.clear();
    _adminNotificationMode.messageController.clear();
  }

  void postSendNotification() {
    if (_adminNotificationMode.titleController.text.isNotEmpty &&
        _adminNotificationMode.messageController.text.isNotEmpty) {
      sendNotification(
        title: _adminNotificationMode.titleController.text,
        message: _adminNotificationMode.messageController.text,
      );
      clearTextFields();
      toast("Notification Sent Successfully");
    }
  }

  Future<void> sendNotification({
    // String? deviceToken,
    String? title,
    String? message,
    String? cTn,
    String? uid,
  }) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';

    // String toParams = "/topics/$uid";

    final data = {
      "notification": {
        "body": title,
        "title": message,
        'android_channel_id': 'Bhagawad_Gita',
        "default_sound": true
      },
      'android': {
        'notification': {'channel_id': 'Bhagawad_Gita', "default_sound": true},
      },
      "priority": "high",
      "data": {
        //   "name": senderName,
        "channel_id": 'Bhagawad_Gita',
        //   "channel_token": cTn,
        //  "user_id": uid,
        //  "to_user_id": ),
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",

        "default_sound": true
      },
      "to":
          'dc1rAaOaRaatDGnXWRzSHh:APA91bHnh7z2AGMv3m8UPF04oEdRq0yuBzMyM60hRNNK2feajxc1dgOwJc6uMUSgRsm6LKAf6tG-Kdh9bVxMTHrucV5vWnxe58TmpurR57XVYMtU-mu-SskIkzN0cvVEjVgfsHsOa9RM',
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAACj1e_c8:APA91bErfjoZUdtUGn7bXNY2r-aiGEkdvC_30zbSIQVMCiav23KUnaFLHqeKggY8Ou0psfH9rmw-cvWHkyVR57VTpAr2FJgQst1BfCM1eW_eSjzZqRLEh-ulNRy0rG9d0Rnop9toy16T '
    };
    var url = Uri.parse(postUrl);

    final response = await http.post(url,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      log("sent notification with data: ${response.body}");
      log("true");
    } else {
      log("failed notification with data: ${response.body}");

      log("false");
    }
  }

  @override
  build() {
    return _adminNotificationMode;
  }
}
