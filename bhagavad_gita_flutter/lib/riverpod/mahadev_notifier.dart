import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final mahadevNotifierProvider =
    AsyncNotifierProvider<MahaDevVideoNotifier, AdminMahaDevMode>(() {
  return MahaDevVideoNotifier();
});

class AdminMahaDevMode {
  List<Video> videos = [];
  Video? currentVideo;
  PodPlayerController? podPlayerController;
}

class MahaDevVideoNotifier extends AsyncNotifier<AdminMahaDevMode> {
  final AdminMahaDevMode _adminMahadevMode = AdminMahaDevMode();

  void init() {
    _adminMahadevMode.podPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        _adminMahadevMode.currentVideo?.url ??
            _adminMahadevMode.videos[0].url,
      ),
    )..initialise();
    //state = AsyncData(_adminMahabharatMode);
  }

  dispose() {
    _adminMahadevMode.podPlayerController?.pause();
    _adminMahadevMode.podPlayerController?.dispose();
    // super.dispose();
  }

  void setCurrentVideo(Video video) {
    _adminMahadevMode.currentVideo = video;
    _adminMahadevMode.podPlayerController?.changeVideo(
      playerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        video.url,
      ),
    );
    state = AsyncData(_adminMahadevMode);
    // notifyListeners();
  }

  setVideos(List<Video> videos) {
    _adminMahadevMode.videos = videos;

    state = AsyncData(_adminMahadevMode);
  }

  @override
  build() {
    return _adminMahadevMode;
  }
}
