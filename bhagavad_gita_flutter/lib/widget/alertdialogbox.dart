import 'package:flutter/cupertino.dart';

import '../utils/file_collection.dart';

Future<void> showMyDialog(
    BuildContext context, String? labelText1, String? contentText1, actiontap2,
    {actiontap1,
    String? actionButtonText1,
    String? actionButtonText2,
    bool? istwobutton = true}) async {
  return showCupertinoDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          labelText1 ?? '',
          style: const TextStyle(
              color: primaryColor, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          if (istwobutton == true) ...{
            CupertinoDialogAction(
              onPressed: actiontap1,
              child: Text(
                actionButtonText1 ?? 'Cancel',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CupertinoDialogAction(
                onPressed: actiontap2,
                child: Text(
                  actionButtonText2 ?? 'Confirm',
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          } else ...{
            CupertinoDialogAction(
                onPressed: actiontap2, child: const Text('Okay')),
          }
        ],
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(contentText1 ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ))
          ],
        ),
      );
    },
  );
}
