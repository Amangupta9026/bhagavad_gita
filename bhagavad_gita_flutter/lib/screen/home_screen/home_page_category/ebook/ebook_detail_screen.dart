import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../local/pref_names.dart';
import '../../../../riverpod/ebook_notifier.dart';

class EbookDetailScreen extends ConsumerStatefulWidget {
  final String? title;
  final String description;
  final String? image;
  const EbookDetailScreen(
      {super.key, this.title, this.description = '', this.image});

  @override
  ConsumerState<EbookDetailScreen> createState() => _EbookDetailScreenState();
}

class _EbookDetailScreenState extends ConsumerState<EbookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final refRead = ref.read(eBookUserNotifierProvider.notifier);
    String? titleWord;
    List<String> titleData = widget.title?.split(' ') ?? [];
    if (titleData.length >= 3) {
      titleWord = '${titleData[0]} ${titleData[1]} ${titleData[2]}';
    } else {
      titleWord = widget.title;
    }

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
                          child: Text(widget.title ?? '',
                              style: const TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 10),
                        Consumer(builder: (context, ref, child) {
                          String? descriptionData;
                          if (widget.description.length >= 4000) {
                            descriptionData =
                                widget.description.substring(0, 4000);
                          } else {
                            descriptionData = widget.description;
                          }

                          return InkWell(
                              onTap: () {
                                refRead.speak(descriptionData.toString());
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
                                text: (widget.description) +
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
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('e-books')
                                .where('bookTitle', isEqualTo: widget.title)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 60),
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                );
                              }
                              return Consumer(
                                builder: (context, ref, child) {
                                  final refRead = ref
                                      .read(eBookUserNotifierProvider.notifier);
                                  return InkWell(
                                      onTap: () {
                                        refRead.changeFaviorite(
                                            widget.title ?? '',
                                            widget.description,
                                            widget.image ?? '');
                                        setState(() {});
                                      },
                                      child: Icon(
                                        FavList.contains(widget.title) == true
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        // ebooks?['isFaviorite'] == true
                                        //     ? Icons.favorite
                                        //     : Icons.favorite_border_outlined,
                                        size: 30,
                                        color: textColor,
                                      ));
                                },
                              );
                            }),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Share.share(
                                '${widget.description.substring(1, 300)} \n\n'
                                'For read more please download Bhagavad Gita App\n\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
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

                    Text(widget.description,
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
