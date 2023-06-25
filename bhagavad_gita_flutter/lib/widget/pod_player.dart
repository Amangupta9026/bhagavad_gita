import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';

import '../riverpod/mahabharat_notifier.dart';
import '../utils/file_collection.dart';

class PodPlayerView extends ConsumerStatefulWidget {
  final String videoUrl;
  final String videoThumbnail;
  final PodPlayerController? podPlayerController;
  const PodPlayerView(
      {required this.videoUrl,
      required this.videoThumbnail,
      required this.podPlayerController,
      super.key});

  @override
  ConsumerState<PodPlayerView> createState() => _PodPlayerViewState();
}

class _PodPlayerViewState extends ConsumerState<PodPlayerView> {
  @override
  Widget build(BuildContext context) {
    final refRead = ref.read(mahabharatNotifierProvider.notifier);
    if (widget.podPlayerController == null) {
      refRead.init();
      // Provider.of<mahabharatNotifierProvider>(context).init();
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return PodVideoPlayer(
      key: ValueKey(widget.videoUrl),
      controller: widget.podPlayerController!,
      podProgressBarConfig: const PodProgressBarConfig(
        bufferedBarColor: primaryColor,
        circleHandlerColor: primaryColor,
        playingBarColor: primaryColor,
      ),
      videoThumbnail: DecorationImage(
        image: Image.network(widget.videoThumbnail).image,
        fit: BoxFit.cover,
      ),
    );
  }
}
