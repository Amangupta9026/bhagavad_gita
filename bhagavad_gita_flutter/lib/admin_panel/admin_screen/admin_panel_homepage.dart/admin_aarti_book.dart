import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/colors.dart';
import '../../../widget/app_bar_header.dart';
import '../../../widget/textformfield_widget.dart';
import '../../admin_riverpod/admin_aarti_book_notifier.dart';

class AdminAartiBook extends ConsumerWidget {
  const AdminAartiBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(aartiBookNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Aarti Book',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Aarti Title',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Consumer(builder: (context, ref, child) {
              return TextFormFieldWidget(
                hinttext1: 'Aarti Name',
                controller1: data.value?.aartiTitleController,
              );
            }),
            const SizedBox(height: 20),
            const Text('Aarti Image',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Consumer(builder: (context, ref, child) {
              return TextFormFieldWidget(
                hinttext1: 'Aarti Image',
                controller1: data.value?.aartiImageController,
              );
            }),
            const SizedBox(height: 20),
            const Text('Aarti Description',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Consumer(builder: (context, ref, child) {
              return TextFormFieldWidget(
                hinttext1: 'Aarti Content',
                maxLines: 4,
                controller1: data.value?.aartiDescriptionController,
              );
            }),

            const SizedBox(height: 50),
            //Button
            Consumer(builder: (context, ref, child) {
              final refRead = ref.read(aartiBookNotifierProvider.notifier);
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    refRead.addAartiBook(context);
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
              );
            }),
          ],
        ),
      ))),
    );
  }
}
