import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/file_collection.dart';
import '../../widget/app_bar_header.dart';
import '../../widget/textformfield_widget.dart';
import '../admin_riverpod/send_notification_from_admin_notifier.dart';

class SendNotificationFromAdmin extends ConsumerWidget {
  const SendNotificationFromAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refRead = ref.read(notificationNotifierProvider.notifier);
    final refWatch = ref.watch(notificationNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBarHeader(
          text: 'Send Notification',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                  fontSize: 18, color: textColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10.0),
             TextFormFieldWidget(
              hinttext1: 'Title',
               controller1: refWatch.value?.titleController,
            ),
            const SizedBox(height: 20),
            const Text(
              'Message',
              style: TextStyle(
                  fontSize: 16, color: textColor, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10.0),
             TextFormFieldWidget(
              hinttext1: 'Message',
            controller1: refWatch.value?.messageController,
            ),
            const SizedBox(height: 20),
            const Text(
              'Image',
            ),
            const SizedBox(height: 10.0),
            const TextFormFieldWidget(
              hinttext1: 'Image',
              // controller1: ref.,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   refRead.postSendNotification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
