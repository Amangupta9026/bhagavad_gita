import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final gitaUpdeshNotifierProvider =
    AsyncNotifierProvider<GitaUpdeshVideoNotifier, AdminGitaUpdeshMode>(() {
  return GitaUpdeshVideoNotifier();
});

class AdminGitaUpdeshMode {
  List<Video> videos = [];
  Video? currentVideo;
  PodPlayerController? podPlayerController;
}

class GitaUpdeshVideoNotifier extends AsyncNotifier<AdminGitaUpdeshMode> {
  final AdminGitaUpdeshMode _adminGitaUpdeshMode = AdminGitaUpdeshMode();

  void init() {
    _adminGitaUpdeshMode.podPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        _adminGitaUpdeshMode.currentVideo?.url ?? _adminGitaUpdeshMode.videos[0].url,
      ),
    )..initialise();
    //state = AsyncData(_adminMahabharatMode);
  }

  dispose() {
    _adminGitaUpdeshMode.podPlayerController?.pause();
    _adminGitaUpdeshMode.podPlayerController?.dispose();
    // super.dispose();
  }

  void setCurrentVideo(Video video) {
    _adminGitaUpdeshMode.currentVideo = video;
    _adminGitaUpdeshMode.podPlayerController?.changeVideo(
      playerConfig: const PodPlayerConfig(autoPlay: true),
      playVideoFrom: PlayVideoFrom.youtube(
        video.url,
      ),
    );
    state = AsyncData(_adminGitaUpdeshMode);
    // notifyListeners();
  }

  setVideos(List<Video> videos) {
    _adminGitaUpdeshMode.videos = videos;

    state = AsyncData(_adminGitaUpdeshMode);
  }

  @override
  build() {
    return _adminGitaUpdeshMode;
  }
}
