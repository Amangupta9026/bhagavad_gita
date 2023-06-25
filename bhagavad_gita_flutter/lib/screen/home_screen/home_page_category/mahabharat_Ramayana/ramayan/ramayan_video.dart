import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../riverpod/ramayana_notifier.dart';
import '../../../../../utils/file_collection.dart';
import '../../../../../utils/utils.dart';
import 'pod_player_ramayana.dart';

class RamayanaVideo extends StatelessWidget {
  final String? title;
  const RamayanaVideo({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final refWatch = ref.watch(ramayanaNotifierProvider);
        final refRead = ref.read(ramayanaNotifierProvider.notifier);
        return WillPopScope(
          onWillPop: () {
            refWatch.value?.podPlayerController?.pause();

            return Future.value(true);
          },
          child: Scaffold(
            body: SafeArea(
              child: Consumer(builder: (context, ref, child) {
                refRead.init();
                List<String>? words = title?.split(" ");
                String? titleWord = '${words?[0]} ${words?[1]}';
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 16, 15),
                      decoration: AppUtils.decoration1(),
                      child: Row(children: [
                        InkWell(
                            onTap: () {
                              refWatch.value?.podPlayerController?.pause();

                              context.pop();
                            },
                            child: const Icon(Icons.arrow_back, size: 30)),
                        const Spacer(),
                        Text(titleWord,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18,
                                color: textColor,
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                      ]),
                    ),
                    RamayanaPodPlayerView(
                      videoUrl: refWatch.value?.currentVideo?.url ??
                          refWatch.value!.videos[0].url,
                      videoThumbnail: refWatch
                              .value?.currentVideo?.thumbnails.standardResUrl ??
                          refWatch.value!.videos[0].thumbnails.standardResUrl,
                      podPlayerController: refWatch.value?.podPlayerController,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: refWatch.value?.videos.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              onTap: () {
                                refRead.setCurrentVideo(
                                    refWatch.value!.videos[index]);
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                    refWatch.value?.videos[index].thumbnails
                                            .lowResUrl ??
                                        '',
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const CupertinoActivityIndicator();
                                }, errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                }),
                              ),
                              title: Text(
                                refWatch.value?.videos[index].title ?? "",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.time,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${refWatch.value?.videos[index].duration?.inMinutes} mins",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
