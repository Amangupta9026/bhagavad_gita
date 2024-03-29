import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../riverpod/aarti_book_detail_notifier.dart';

class AartiBookDetailScreen extends ConsumerWidget {
  final String? title;
  final String? description;
  final String? image;
  const AartiBookDetailScreen(
      {super.key, this.title, this.description, this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refRead = ref.read(aartiBookUserNotifierProvider.notifier);
    List<String>? titleData = title?.split(' ');
    String? titleWord = '${titleData?[0]} ${titleData?[1]} ${titleData?[2]}';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarHeader(
          text: titleWord,
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Opacity(
            opacity: 0.57,
            child: Image.asset(
              'assets/images/bg4.jpg',
              // width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(title ?? '',
                              style: const TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 10),
                        Consumer(builder: (context, ref, child) {
                          return InkWell(
                              onTap: () {
                                refRead.speak(description ?? '');
                              },
                              child: const Icon(Icons.volume_up_outlined,
                                  size: 30, color: textColor));
                        }),
                        const SizedBox(width: 10),
                        Consumer(builder: (context, ref, child) {
                          return InkWell(
                              onTap: () {
                                refRead.stop();
                              },
                              child: const Icon(Icons.pause_outlined,
                                  size: 30, color: textColor));
                        }),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                text: (description ?? '') +
                                    ('\n\n\nFor Read More Please Download Bhagavad Gita App\n\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US')));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copied to clipboard'),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.copy,
                            size: 30,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Share.share(
                                '${description?.substring(1, 300) ?? ''} \n\n'
                                'For Read More Please Download Bhagavad Gita App\n\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
                          },
                          child: const Icon(
                            Icons.share_outlined,
                            size: 30,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // About the book

                    Text(description ?? '',
                        style: const TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            //color: Colors.white,
                            fontSize: 18)),
                  ]),
            ),
          ),
        ],
      )),
    );
  }
}
