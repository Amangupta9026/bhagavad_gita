import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final ramayanaNotifierProvider =
    AsyncNotifierProvider<RamayanaVideoNotifier, AdminRamayanaMode>(() {
  return RamayanaVideoNotifier();
});

class AdminRamayanaMode {
  List<Video> videos = [];
  Video? currentVideo;
  PodPlayerController? podPlayerController;
}

class RamayanaVideoNotifier extends AsyncNotifier<AdminRamayanaMode> {
  final AdminRamayanaMode _adminRamayanaMode = AdminRamayanaMode();

  void init() {
    _adminRamayanaMode.podPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        _adminRamayanaMode.currentVideo?.url ??
            _adminRamayanaMode.videos[0].url,
      ),
    )..initialise();
    //state = AsyncData(_adminMahabharatMode);
  }

  dispose() {
    _adminRamayanaMode.podPlayerController?.pause();
    _adminRamayanaMode.podPlayerController?.dispose();
    // super.dispose();
  }

  void setCurrentVideo(Video video) {
    _adminRamayanaMode.currentVideo = video;
    _adminRamayanaMode.podPlayerController?.changeVideo(
      playerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        video.url,
      ),
    );
    state = AsyncData(_adminRamayanaMode);
    // notifyListeners();
  }

  setVideos(List<Video> videos) {
    _adminRamayanaMode.videos = videos;

    state = AsyncData(_adminRamayanaMode);
  }

  @override
  build() {
    return _adminRamayanaMode;
  }
}
