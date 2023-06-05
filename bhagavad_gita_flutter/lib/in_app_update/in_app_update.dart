import 'dart:developer';

import 'package:in_app_update/in_app_update.dart';

class UpdateChecker {
  static Future<void> checkForUpdate() async {
    try {
      InAppUpdate.checkForUpdate().then((info) {
        if (info.updateAvailability == UpdateAvailability.updateAvailable &&
            info.immediateUpdateAllowed) {
          InAppUpdate.performImmediateUpdate().catchError((e) {
            log("$e");
            return AppUpdateResult.inAppUpdateFailed;
          });
        } else if (info.updateAvailability ==
                UpdateAvailability.updateAvailable &&
            info.flexibleUpdateAllowed) {
          InAppUpdate.startFlexibleUpdate().catchError((e) {
            log("$e");
            return AppUpdateResult.inAppUpdateFailed;
          });
        }
      }).catchError((e) {
        log("$e");
      });
    } catch (e) {
      log("$e");
    }
  }
}
