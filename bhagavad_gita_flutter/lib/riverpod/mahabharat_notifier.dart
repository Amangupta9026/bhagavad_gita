import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final mahabharatNotifierProvider =
    AsyncNotifierProvider<MahabharatVideoNotifier, AdminMahabharatMode>(() {
  return MahabharatVideoNotifier();
});

class AdminMahabharatMode {
  List<Video> videos = [];
  Video? currentVideo;
  PodPlayerController? podPlayerController;
}

class MahabharatVideoNotifier extends AsyncNotifier<AdminMahabharatMode> {
  final AdminMahabharatMode _adminMahabharatMode = AdminMahabharatMode();

  void init() {
    _adminMahabharatMode.podPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        _adminMahabharatMode.currentVideo?.url ??
            _adminMahabharatMode.videos[0].url,
      ),
    )..initialise();
    //state = AsyncData(_adminMahabharatMode);
  }

  dispose() {
    _adminMahabharatMode.podPlayerController?.pause();
    _adminMahabharatMode.podPlayerController?.dispose();
   // super.dispose();
  }

  void setCurrentVideo(Video video) {
    _adminMahabharatMode.currentVideo = video;
    _adminMahabharatMode.podPlayerController?.changeVideo(
      playerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        video.url,
      ),
    );
    state = AsyncData(_adminMahabharatMode);
    // notifyListeners();
  }

  setVideos(List<Video> videos) {
    _adminMahabharatMode.videos = videos;

    state = AsyncData(_adminMahabharatMode);
  }

  @override
  build() {
    return _adminMahabharatMode;
  }
}
