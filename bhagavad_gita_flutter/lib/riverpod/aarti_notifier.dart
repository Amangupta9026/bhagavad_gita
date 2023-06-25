import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final aartiNotifierProvider =
    AsyncNotifierProvider<AartiNotifier, AdminAartiMode>(() {
  return AartiNotifier();
});

class AdminAartiMode {
  List<Video> videos = [];
  Video? currentVideo;
  PodPlayerController? podPlayerController;
}

class AartiNotifier extends AsyncNotifier<AdminAartiMode> {
  final AdminAartiMode _adminAartiMode = AdminAartiMode();

  void init() {
    _adminAartiMode.podPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        _adminAartiMode.currentVideo?.url ?? _adminAartiMode.videos[0].url,
      ),
    )..initialise();
    //state = AsyncData(_adminMahabharatMode);
  }

  dispose() {
    _adminAartiMode.podPlayerController?.pause();
    _adminAartiMode.podPlayerController?.dispose();
    // super.dispose();
  }

  void setCurrentVideo(Video video) {
    _adminAartiMode.currentVideo = video;
    _adminAartiMode.podPlayerController?.changeVideo(
      playerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        video.url,
      ),
    );
    state = AsyncData(_adminAartiMode);
    // notifyListeners();
  }

  setVideos(List<Video> videos) {
    _adminAartiMode.videos = videos;

    state = AsyncData(_adminAartiMode);
  }

  @override
  build() {
    return _adminAartiMode;
  }
}
