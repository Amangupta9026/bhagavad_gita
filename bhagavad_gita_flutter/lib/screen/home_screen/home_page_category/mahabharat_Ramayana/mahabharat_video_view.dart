// import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/mahabharat_Ramayana/pod_player.dart';
// import 'package:bhagavad_gita_flutter/utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../riverpod/mahabharat_notifier.dart';
// import '../../../../utils/file_collection.dart';

// class CourseView extends ConsumerWidget {
//   const CourseView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final refRead = ref.read(mahabharatNotifierProvider.notifier);

//     return WillPopScope(
//       onWillPop: () {
//         refRead.podPlayerController?.pause();
//        // context.read<CourseVideoNotifier>().podPlayerController?.pause();
//         return Future.value(true);
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Consumer(builder: (context, ref, child) {

//             ref.init();
//             return Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(20, 16, 16, 15),
//                   decoration: AppUtils.decoration1(),
//                   child: Row(children: [
//                     InkWell(
//                         onTap: () {
//                           context
//                               .read<CourseVideoNotifier>()
//                               .podPlayerController
//                               ?.pause();
//                           context.pop();
//                         },
//                         child: const Icon(Icons.arrow_back, size: 30)),
//                     const Spacer(),
//                     const Text('Video',
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: textColor,
//                             fontWeight: FontWeight.bold)),
//                     const Spacer(),
//                   ]),
//                 ),
//                 PodPlayerView(
//                   videoUrl: ref.currentVideo?.url ?? ref.videos[0].url,
//                   videoThumbnail: ref.currentVideo?.thumbnails.standardResUrl ??
//                       ref.videos[0].thumbnails.standardResUrl,
//                   podPlayerController: ref.podPlayerController,
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: ref.videos.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: ListTile(
//                           onTap: () {
//                             ref.setCurrentVideo(ref.videos[index]);
//                           },
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               ref.videos[index].thumbnails.lowResUrl,
//                               loadingBuilder:
//                                   (context, child, loadingProgress) {
//                                 if (loadingProgress == null) {
//                                   return child;
//                                 }
//                                 return const CupertinoActivityIndicator();
//                               },
//                             ),
//                           ),
//                           title: Text(
//                             ref.videos[index].title,
//                             style: const TextStyle(
//                               fontSize: 12,
//                             ),
//                           ),
//                           subtitle: Row(
//                             children: [
//                               const Icon(
//                                 CupertinoIcons.time,
//                                 size: 12,
//                               ),
//                               const SizedBox(
//                                 width: 4,
//                               ),
//                               Text(
//                                 "${ref.videos[index].duration?.inMinutes} mins",
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
