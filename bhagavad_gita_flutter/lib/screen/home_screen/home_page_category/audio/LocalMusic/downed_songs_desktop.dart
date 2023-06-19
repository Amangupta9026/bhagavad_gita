import 'dart:developer';
import 'dart:io';

import '../CustomWidgets/custom_physics.dart';

import '../CustomWidgets/empty_screen.dart';
import '../CustomWidgets/gradient_containers.dart';
import '../CustomWidgets/playlist_head.dart';

import '../audio service/miniplayer.dart';
import '../audio service/player_service.dart';
import '../audio_query.dart';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

class DownloadedSongsDesktop extends StatefulWidget {
  final List<Map>? cachedSongs;
  final String? title;
  final int? playlistId;
  // final bool showPlaylists;
  const DownloadedSongsDesktop({
    super.key,
    this.cachedSongs,
    this.title,
    this.playlistId,
    // this.showPlaylists = false,
  });
  @override
  State<DownloadedSongsDesktop> createState() => _DownloadedSongsDesktopState();
}

class _DownloadedSongsDesktopState extends State<DownloadedSongsDesktop>
    with TickerProviderStateMixin {
  List<Map> _songs = [];
  String? tempPath = Hive.box('settings').get('tempDirPath')?.toString();
  final Map<String, List<Map>> _albums = {};
  final Map<String, List<Map>> _artists = {};
  final Map<String, List<Map>> _genres = {};

  final List<String> _sortedAlbumKeysList = [];
  final List<String> _sortedArtistKeysList = [];
  final List<String> _sortedGenreKeysList = [];
  // final List<String> _videos = [];

  bool added = false;
  int sortValue = Hive.box('settings').get('sortValue', defaultValue: 1) as int;
  int orderValue =
      Hive.box('settings').get('orderValue', defaultValue: 1) as int;
  int albumSortValue =
      Hive.box('settings').get('albumSortValue', defaultValue: 2) as int;
  List dirPaths =
      Hive.box('settings').get('searchPaths', defaultValue: []) as List;
  int minDuration =
      Hive.box('settings').get('minDuration', defaultValue: 10) as int;
  bool includeOrExclude =
      Hive.box('settings').get('includeOrExclude', defaultValue: false) as bool;
  List includedExcludedPaths = Hive.box('settings')
      .get('includedExcludedPaths', defaultValue: []) as List;
  TabController? _tcontroller;
  OfflineAudioQuery offlineAudioQuery = OfflineAudioQuery();
  List<Map> playlistDetails = [];

  @override
  void initState() {
    _tcontroller = TabController(length: 4, vsync: this);
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tcontroller!.dispose();
  }

  void getSongs() {
    final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
    for (final path in includedExcludedPaths) {
      final dir = Directory(path.toString());
      try {
        final files = dir.listSync(recursive: true);
        for (final file in files) {
          if (file.path.endsWith('.mp3') || file.path.endsWith('.m4a')) {
            _songs.add({
              'id': file.path.replaceAll(avoid, '').replaceAll('  ', ' '),
              'title':
                  (file.path.split('\\').last.split('.')..removeLast()).join(),
              'artist': 'Unknown',
              'album': 'Unknown',
              'image': '',
              'year': '',
              'subtitle': file.path.split('\\').last,
              'quality': '',
              'genre': 'Unknown',
              'path': file.path,
            });
          }
        }
      } catch (e) {
        log('$e');
      }
    }
  }

  Future<void> getData() async {
    // await offlineAudioQuery.requestPermission();
    tempPath ??= (await getTemporaryDirectory()).path;
    // playlistDetails = await offlineAudioQuery.getPlaylists();
    if (widget.cachedSongs == null) {
      getSongs();
    } else {
      _songs = widget.cachedSongs!;
    }
    added = true;
    setState(() {});
   
  }

  

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(
                    widget.title ?? 'MyMusic',
                  ),
                  bottom: TabBar(
                    // isScrollable: true,
                    controller: _tcontroller,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(
                        text: 'Songs',
                      ),
                      Tab(
                        text: 'Albums',
                      ),
                      Tab(
                        text: 'Artists',
                      ),
                      Tab(
                        text: 'Genres',
                      ),
                    ],
                  ),
                  centerTitle: true,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                ),
                body: !added
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : TabBarView(
                        physics: const CustomPhysics(),
                        controller: _tcontroller,
                        children: [
                          SongsTab(
                            songs: _songs,
                            playlistId: widget.playlistId,
                            playlistName: widget.title,
                            tempPath: tempPath!,
                          ),
                          AlbumsTabDesktop(
                            albums: _albums,
                            albumsList: _sortedAlbumKeysList,
                            tempPath: tempPath!,
                          ),
                          AlbumsTabDesktop(
                            albums: _artists,
                            albumsList: _sortedArtistKeysList,
                            tempPath: tempPath!,
                          ),
                          AlbumsTabDesktop(
                            albums: _genres,
                            albumsList: _sortedGenreKeysList,
                            tempPath: tempPath!,
                          ),
                          // if (widget.showPlaylists)
                          //   LocalPlaylists(
                          //     playlistDetails: playlistDetails,
                          //     offlineAudioQuery: offlineAudioQuery,
                          //   ),
                          // videosTab(),
                        ],
                      ),
              ),
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}

class SongsTab extends StatefulWidget {
  final List<Map> songs;
  final int? playlistId;
  final String? playlistName;
  final String tempPath;
  const SongsTab({
    super.key,
    required this.songs,
    required this.tempPath,
    this.playlistId,
    this.playlistName,
  });

  @override
  State<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.songs.isEmpty
        ? emptyScreen(
            context,
            3,
            'Nothing To',
            15.0,
            'Show Here',
            45,
            'Download Something',
            23.0,
          )
        : Column(
            children: [
              PlaylistHead(
                songsList: widget.songs,
                offline: true,
                fromDownloads: false,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 10),
                  shrinkWrap: true,
                  itemExtent: 70.0,
                  itemCount: widget.songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: const Image(
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          image: AssetImage('assets/images/cover.jpg'),
                        ),
                      ),
                      title: Text(
                        widget.songs[index]['title'].toString(),
                        // widget.songs[index].title.trim() != ''
                        // ? widget.songs[index].title
                        // : widget.songs[index].displayNameWOExt,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        PlayerInvoke.init(
                          songsList: widget.songs,
                          index: index,
                          isOffline: true,
                          recommend: false,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }
}

class AlbumsTabDesktop extends StatefulWidget {
  final Map<String, List<Map>> albums;
  final List<String> albumsList;
  final String tempPath;
  const AlbumsTabDesktop({
    super.key,
    required this.albums,
    required this.albumsList,
    required this.tempPath,
  });

  @override
  State<AlbumsTabDesktop> createState() => _AlbumsTabDesktopState();
}

class _AlbumsTabDesktopState extends State<AlbumsTabDesktop>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      shrinkWrap: true,
      itemExtent: 70.0,
      itemCount: widget.albumsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          // leading: OfflineAudioQuery.offlineArtworkWidget(
          //   id: widget.albums[widget.albumsList[index]]![0].id,
          //   type: ArtworkType.AUDIO,
          //   tempPath: widget.tempPath,
          //   fileName:
          //       widget.albums[widget.albumsList[index]]![0].displayNameWOExt,
          // ),
          title: Text(
            widget.albumsList[index],
            overflow: TextOverflow.ellipsis,
          ),
          // subtitle: Text(
          //   '${widget.albums[widget.albumsList[index]]!.length} ${AppLocalizations.of(context)!.songs}',
          // ),
          onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => DownloadedSongs(
            //         title: widget.albumsList[index],
            //         cachedSongs: widget.albums[widget.albumsList[index]],
            //       ),
            //     ),
            //   );
          },
        );
      },
    );
  }
}
