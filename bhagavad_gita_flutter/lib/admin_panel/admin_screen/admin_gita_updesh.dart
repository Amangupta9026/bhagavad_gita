import 'package:bhagavad_gita_flutter/widget/textformfield_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/file_collection.dart';
import '../../../widget/app_bar_header.dart';
import '../admin_riverpod/admin_gita_updesh_notifier.dart';


class AdminGitaUpdesh extends ConsumerWidget {
  const AdminGitaUpdesh({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(adminGitaUpdeshNotifierProvider);
    final refRead = ref.watch(adminGitaUpdeshNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Gita Updesh',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Playlist Url',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'Playlist Url',
              controller1: data.value?.playListController,
            ),

            const SizedBox(height: 20),
            const Text('Title',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'Playlist Title',
              controller1: data.value?.titleController,
            ),

            const SizedBox(height: 50),
            //Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  refRead.playListUrlAdd(context);
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
