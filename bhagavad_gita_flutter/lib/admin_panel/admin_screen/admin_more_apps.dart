import 'dart:io';

import 'package:bhagavad_gita_flutter/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/colors.dart';
import '../../widget/app_bar_header.dart';
import '../admin_riverpod/admin_more_apps_notifier.dart';

class AdminMoreApps extends ConsumerWidget {
  const AdminMoreApps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(moreAppsNotifierProvider);
    final refRead = ref.read(moreAppsNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Admin More Apps',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('App Name',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'App Name',
              controller1: data.value?.appNameController,
            ),

            const SizedBox(height: 20),
            const Text('App link',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hinttext1: 'App Link',
              controller1: data.value?.appLinkController,
            ),

            const SizedBox(height: 20),
            const Text('App Image',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),
            if (data.value?.getImage == null)
              InkWell(
                onTap: () {
                  refRead.pickImage();
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.photo,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),

            InkWell(
              onTap: () {
                refRead.removeImage();
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Image.file(
                      File(data.value?.getImage?.path ?? ''),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    top: -4,
                    right: -4,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
