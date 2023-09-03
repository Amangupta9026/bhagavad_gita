import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../../utils/file_collection.dart';
import '../../../../riverpod/mahadev_notifier.dart';

class MahaDevPodPlayerView extends ConsumerStatefulWidget {
  final String videoUrl;
  final String videoThumbnail;
  final PodPlayerController? podPlayerController;
  const MahaDevPodPlayerView(
      {required this.videoUrl,
      required this.videoThumbnail,
      required this.podPlayerController,
      super.key});

  @override
  ConsumerState<MahaDevPodPlayerView> createState() => _PodPlayerViewState();
}

class _PodPlayerViewState extends ConsumerState<MahaDevPodPlayerView> {
  @override
  Widget build(BuildContext context) {
    final refRead = ref.read(mahadevNotifierProvider.notifier);
    if (widget.podPlayerController == null) {
      refRead.init();
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
