import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/colors.dart';
import '../../widget/app_bar_header.dart';
import '../admin_riverpod/admin_wallpaper_notifier.dart';

class AdminWallpaper extends ConsumerWidget {
  const AdminWallpaper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageList = ref.watch(adminWallpaperNotifierProvider);
    final refRead = ref.read(adminWallpaperNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Admin Wallpaper',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wallpaper',
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),

            //Gallery Icon
            InkWell(
              onTap: () => refRead.selectImages(),
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

            const SizedBox(height: 20),
            if (imageList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Selected Images: ${imageList.length}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: textColor,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: imageList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              refRead.removeImage(index);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.file(
                                  File(imageList[index].path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                const Positioned.fill(
                                  top: -8,
                                  right: -8,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.cancel,
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),

            const SizedBox(height: 50),

            //Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
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
