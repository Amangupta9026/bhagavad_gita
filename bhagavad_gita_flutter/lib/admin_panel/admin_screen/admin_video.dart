import 'package:bhagavad_gita_flutter/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/colors.dart';
import '../../widget/app_bar_header.dart';
import '../admin_riverpod/admin_video_notifier.dart';

class AdminVideo extends ConsumerWidget {
  const AdminVideo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(videoNotifierProvider);
    final refRead = ref.read(videoNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Admin Video',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Video Title',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'Video Name',
              controller1: data.value?.videoTitleController,
            ),
            const SizedBox(height: 20),
            const Text('Video Image',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'Video Image',
              controller1: data.value?.videoImageController,
            ),
            const SizedBox(height: 20),
            const Text('Videl link',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'Video Link',
              controller1: data.value?.videoUrlController,
            ),

            const SizedBox(height: 50),
            //Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  refRead.onSubmit(context);
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
