// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pod_player/pod_player.dart';


// import '../../../../utils/file_collection.dart';

// class PodPlayerView extends StatefulWidget {
//   final String videoUrl;
//   // final String videoThumbnail;
//   final PodPlayerController? podPlayerController;
//   const PodPlayerView(
//       {required this.videoUrl,
//       // required this.videoThumbnail,
//       required this.podPlayerController,
//       super.key});

//   @override
//   State<PodPlayerView> createState() => _PodPlayerViewState();
// }

// class _PodPlayerViewState extends State<PodPlayerView> {

//   @override
//   Widget build(BuildContext context) {
//     if (widget.podPlayerController == null) {
//       Provider.of<mahabharatNotifierProvider>(context).init();
      
//      //Provider.of<mahabharatNotifierProvider>(context).init();
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     return PodVideoPlayer(
//       key: ValueKey(widget.videoUrl),
//       controller: widget.podPlayerController!,
//       podProgressBarConfig: const PodProgressBarConfig(
//         bufferedBarColor: primaryColor,
//         circleHandlerColor: primaryColor,
//         playingBarColor: primaryColor,
//       ),
//       videoThumbnail: DecorationImage(
//         image: Image.network(widget.videoThumbnail).image,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }
