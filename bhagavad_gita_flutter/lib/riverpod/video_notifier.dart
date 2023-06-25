import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final videoNotifierProvider =
    AsyncNotifierProvider<VideoNotifier, AdminVideoMode>(() {
  return VideoNotifier();
});

class AdminVideoMode {
  List<Video> videos = [];
  Video? currentVideo;
  PodPlayerController? podPlayerController;
}

class VideoNotifier extends AsyncNotifier<AdminVideoMode> {
  final AdminVideoMode _adminVideoMode = AdminVideoMode();

  void init() {
    _adminVideoMode.podPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        _adminVideoMode.currentVideo?.url ??
            _adminVideoMode.videos[0].url,
      ),
    )..initialise();
    //state = AsyncData(_adminMahabharatMode);
  }

  dispose() {
    _adminVideoMode.podPlayerController?.pause();
    _adminVideoMode.podPlayerController?.dispose();
    // super.dispose();
  }

  void setCurrentVideo(Video video) {
    _adminVideoMode.currentVideo = video;
    _adminVideoMode.podPlayerController?.changeVideo(
      playerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        video.url,
      ),
    );
    state = AsyncData(_adminVideoMode);
    // notifyListeners();
  }

  setVideos(List<Video> videos) {
    _adminVideoMode.videos = videos;

    state = AsyncData(_adminVideoMode);
  }

  @override
  build() {
    return _adminVideoMode;
  }
}
