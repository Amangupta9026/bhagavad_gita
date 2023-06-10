import 'package:bhagavad_gita_flutter/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/colors.dart';
import '../../widget/app_bar_header.dart';
import '../admin_riverpod/admin_ebook_notifier.dart';

class AdminEbook extends ConsumerWidget {
  const AdminEbook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(eBookNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'E-Books',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Book Title',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Consumer(builder: (context, ref, child) {
              return TextFormFieldWidget(
                hinttext1: 'Book Name',
                controller1: data.bookTitleController,
              );
            }),
            const SizedBox(height: 20),
            const Text('Book Image',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Consumer(builder: (context, ref, child) {
              return TextFormFieldWidget(
                hinttext1: 'Book Image',
                controller1: data.bookImageController,
              );
            }),
            const SizedBox(height: 20),
            const Text('Book Description',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Consumer(builder: (context, ref, child) {
              return TextFormFieldWidget(
                hinttext1: 'Book Content',
                controller1: data.bookDescriptionController,
              );
            }),

            const SizedBox(height: 50),
            //Button
            Consumer(builder: (context, ref, child) {
              final data = ref.read(eBookNotifierProvider.notifier);
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    data.addBook();
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
