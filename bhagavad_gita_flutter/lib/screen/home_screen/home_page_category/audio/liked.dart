import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/audio/audio%20service/player_service.dart';

import 'CustomWidgets/collage.dart';
import 'CustomWidgets/custom_physics.dart';
import 'CustomWidgets/data_search.dart';
import 'CustomWidgets/download_button.dart';
import 'CustomWidgets/empty_screen.dart';
import 'CustomWidgets/gradient_containers.dart';
import 'CustomWidgets/like_button.dart';
import 'audio service/miniplayer.dart';
import 'CustomWidgets/playlist_head.dart';
import 'CustomWidgets/song_tile_trailing_menu.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

final ValueNotifier<bool> selectMode = ValueNotifier<bool>(false);
final Set<String> selectedItems = <String>{};

class LikedSongs extends StatefulWidget {
  final String playlistName;
  final String? showName;
  final bool fromPlaylist;
  final List? songs;
  const LikedSongs({
    super.key,
    required this.playlistName,
    this.showName,
    this.fromPlaylist = false,
    this.songs,
  });
  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs>
    with SingleTickerProviderStateMixin {
  Box? likedBox;
  bool added = false;
  // String? tempPath = Hive.box('settings').get('tempDirPath')?.toString();
  List _songs = [];
  final Map<String, List<Map>> _albums = {};
  final Map<String, List<Map>> _artists = {};
  final Map<String, List<Map>> _genres = {};
  List _sortedAlbumKeysList = [];
  List _sortedArtistKeysList = [];
  List _sortedGenreKeysList = [];
  TabController? _tcontroller;
  // int currentIndex = 0;
  int sortValue = Hive.box('settings').get('sortValue', defaultValue: 1) as int;
  int orderValue =
      Hive.box('settings').get('orderValue', defaultValue: 1) as int;
  int albumSortValue =
      Hive.box('settings').get('albumSortValue', defaultValue: 2) as int;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showShuffle = ValueNotifier<bool>(true);

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void initState() {
    _tcontroller = TabController(length: 4, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _showShuffle.value = false;
      } else {
        _showShuffle.value = true;
      }
    });
    // if (tempPath == null) {
    //   getTemporaryDirectory().then((value) {
    //     Hive.box('settings').put('tempDirPath', value.path);
    //   });
    // }
    // _tcontroller!.addListener(changeTitle);
    getLiked();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tcontroller!.dispose();
    _scrollController.dispose();
  }

  // void changeTitle() {
  //   setState(() {
  //     currentIndex = _tcontroller!.index;
  //   });
  // }

  void getLiked() {
    likedBox = Hive.box(widget.playlistName);
    if (widget.fromPlaylist) {
      _songs = widget.songs!;
    } else {
      _songs = likedBox?.values.toList() ?? [];
      // songs_count.addSongsCount(
      //   widget.playlistName,
      //   _songs.length,
      //   _songs.length >= 4
      //       ? _songs.sublist(0, 4)
      //       : _songs.sublist(0, _songs.length),
      // );
    }
    setArtistAlbum();
  }

  void setArtistAlbum() {
    for (final element in _songs) {
      if (_albums.containsKey(element['album'])) {
        final List<Map> tempAlbum = _albums[element['album']]!;
        tempAlbum.add(element as Map);
        _albums.addEntries([MapEntry(element['album'].toString(), tempAlbum)]);
      } else {
        _albums.addEntries([
          MapEntry(element['album'].toString(), [element as Map])
        ]);
      }

      element['artist'].toString().split(', ').forEach((singleArtist) {
        if (_artists.containsKey(singleArtist)) {
          final List<Map> tempArtist = _artists[singleArtist]!;
          tempArtist.add(element);
          _artists.addEntries([MapEntry(singleArtist, tempArtist)]);
        } else {
          _artists.addEntries([
            MapEntry(singleArtist, [element])
          ]);
        }
      });

      if (_genres.containsKey(element['genre'])) {
        final List<Map> tempGenre = _genres[element['genre']]!;
        tempGenre.add(element);
        _genres.addEntries([MapEntry(element['genre'].toString(), tempGenre)]);
      } else {
        _genres.addEntries([
          MapEntry(element['genre'].toString(), [element])
        ]);
      }
    }

    sortSongs(sortVal: sortValue, order: orderValue);

    _sortedAlbumKeysList = _albums.keys.toList();
    _sortedArtistKeysList = _artists.keys.toList();
    _sortedGenreKeysList = _genres.keys.toList();

    sortAlbums();

    added = true;
    setState(() {});
  }

  void sortSongs({required int sortVal, required int order}) {
    switch (sortVal) {
      case 0:
        _songs.sort(
          (a, b) => a['title']
              .toString()
              .toUpperCase()
              .compareTo(b['title'].toString().toUpperCase()),
        );
        break;
      case 1:
        _songs.sort(
          (a, b) => a['dateAdded']
              .toString()
              .toUpperCase()
              .compareTo(b['dateAdded'].toString().toUpperCase()),
        );
        break;
      case 2:
        _songs.sort(
          (a, b) => a['album']
              .toString()
              .toUpperCase()
              .compareTo(b['album'].toString().toUpperCase()),
        );
        break;
      case 3:
        _songs.sort(
          (a, b) => a['artist']
              .toString()
              .toUpperCase()
              .compareTo(b['artist'].toString().toUpperCase()),
        );
        break;
      case 4:
        _songs.sort(
          (a, b) => a['duration']
              .toString()
              .toUpperCase()
              .compareTo(b['duration'].toString().toUpperCase()),
        );
        break;
      default:
        _songs.sort(
          (b, a) => a['dateAdded']
              .toString()
              .toUpperCase()
              .compareTo(b['dateAdded'].toString().toUpperCase()),
        );
        break;
    }

    if (order == 1) {
      _songs = _songs.reversed.toList();
    }
  }

  void sortAlbums() {
    if (albumSortValue == 0) {
      _sortedAlbumKeysList.sort(
        (a, b) =>
            a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
      );
      _sortedArtistKeysList.sort(
        (a, b) =>
            a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
      );
      _sortedGenreKeysList.sort(
        (a, b) =>
            a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
      );
    }
    if (albumSortValue == 1) {
      _sortedAlbumKeysList.sort(
        (b, a) =>
            a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
      );
      _sortedArtistKeysList.sort(
        (b, a) =>
            a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
      );
      _sortedGenreKeysList.sort(
        (b, a) =>
            a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
      );
    }
    if (albumSortValue == 2) {
      _sortedAlbumKeysList
          .sort((b, a) => _albums[a]!.length.compareTo(_albums[b]!.length));
      _sortedArtistKeysList
          .sort((b, a) => _artists[a]!.length.compareTo(_artists[b]!.length));
      _sortedGenreKeysList
          .sort((b, a) => _genres[a]!.length.compareTo(_genres[b]!.length));
    }
    if (albumSortValue == 3) {
      _sortedAlbumKeysList
          .sort((a, b) => _albums[a]!.length.compareTo(_albums[b]!.length));
      _sortedArtistKeysList
          .sort((a, b) => _artists[a]!.length.compareTo(_artists[b]!.length));
      _sortedGenreKeysList
          .sort((a, b) => _genres[a]!.length.compareTo(_genres[b]!.length));
    }
    if (albumSortValue == 4) {
      _sortedAlbumKeysList.shuffle();
      _sortedArtistKeysList.shuffle();
      _sortedGenreKeysList.shuffle();
    }
  }

  void deleteLiked(Map song) {
    setState(() {
      likedBox!.delete(song['id']);
      if (_albums[song['album']]!.length == 1) {
        _sortedAlbumKeysList.remove(song['album']);
      }
      _albums[song['album']]!.remove(song);

      song['artist'].toString().split(', ').forEach((singleArtist) {
        if (_artists[singleArtist]!.length == 1) {
          _sortedArtistKeysList.remove(singleArtist);
        }
        _artists[singleArtist]!.remove(song);
      });

      if (_genres[song['genre']]!.length == 1) {
        _sortedGenreKeysList.remove(song['genre']);
      }
      _genres[song['genre']]!.remove(song);

      _songs.remove(song);
      // songs_count.addSongsCount(
      //   widget.playlistName,
      //   _songs.length,
      //   _songs.length >= 4
      //       ? _songs.sublist(0, 4)
      //       : _songs.sublist(0, _songs.length),
      // );
    });
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
                    widget.showName == null
                        ? widget.playlistName[0].toUpperCase() +
                            widget.playlistName.substring(1)
                        : widget.showName![0].toUpperCase() +
                            widget.showName!.substring(1),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  centerTitle: true,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  bottom: TabBar(
                    controller: _tcontroller,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(text: 'Songs'),
                      Tab(
                        text: 'Albumn',
                      ),
                      Tab(
                        text: 'Artists',
                      ),
                      Tab(
                        text: 'Genres',
                      ),
                    ],
                  ),
                  actions: [
                    ValueListenableBuilder(
                      valueListenable: selectMode,
                      child: Row(
                        children: <Widget>[
                          if (_songs.isNotEmpty)
                            MultiDownloadButton(
                              data: _songs,
                              playlistName: widget.showName == null
                                  ? widget.playlistName[0].toUpperCase() +
                                      widget.playlistName.substring(1)
                                  : widget.showName![0].toUpperCase() +
                                      widget.showName!.substring(1),
                            ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.search),
                            tooltip: 'zz',
                            //AppLocalizations.of(context)!.search,
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: DownloadsSearch(data: _songs),
                              );
                            },
                          ),
                          PopupMenuButton(
                            icon: const Icon(Icons.sort_rounded),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            onSelected:
                                // (currentIndex == 0) ?
                                (int value) {
                              if (value < 5) {
                                sortValue = value;
                                Hive.box('settings').put('sortValue', value);
                              } else {
                                orderValue = value - 5;
                                Hive.box('settings')
                                    .put('orderValue', orderValue);
                              }
                              sortSongs(sortVal: sortValue, order: orderValue);
                              setState(() {});
                            },
                            // : (int value) {
                            //     albumSortValue = value;
                            //     Hive.box('settings').put('albumSortValue', value);
                            //     sortAlbums();
                            //     setState(() {});
                            //   },
                            itemBuilder:
                                // (currentIndex == 0)
                                // ?
                                (context) {
                              final List<String> sortTypes = [
                                'Display Name',
                                'date',
                                'album',
                                'artist',
                                'duration',
                                //     AppLocalizations.of(context)!.displayName,
                                //  AppLocalizations.of(context)!.dateAdded,
                                //  AppLocalizations.of(context)!.album,
                                //    AppLocalizations.of(context)!.artist,
                                //    AppLocalizations.of(context)!.duration,
                              ];
                              final List<String> orderTypes = [
                                'asc',
                                'desc',
                                //     AppLocalizations.of(context)!.inc,
                                //     AppLocalizations.of(context)!.dec,
                              ];
                              final menuList = <PopupMenuEntry<int>>[];
                              menuList.addAll(
                                sortTypes
                                    .map(
                                      (e) => PopupMenuItem(
                                        value: sortTypes.indexOf(e),
                                        child: Row(
                                          children: [
                                            if (sortValue ==
                                                sortTypes.indexOf(e))
                                              Icon(
                                                Icons.check_rounded,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.grey[700],
                                              )
                                            else
                                              const SizedBox(),
                                            const SizedBox(width: 10),
                                            Text(
                                              e,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                              menuList.add(
                                const PopupMenuDivider(
                                  height: 10,
                                ),
                              );
                              menuList.addAll(
                                orderTypes
                                    .map(
                                      (e) => PopupMenuItem(
                                        value: sortTypes.length +
                                            orderTypes.indexOf(e),
                                        child: Row(
                                          children: [
                                            if (orderValue ==
                                                orderTypes.indexOf(e))
                                              Icon(
                                                Icons.check_rounded,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.grey[700],
                                              )
                                            else
                                              const SizedBox(),
                                            const SizedBox(width: 10),
                                            Text(
                                              e,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                              return menuList;
                            },
                          ),
                        ],
                      ),
                      builder: (
                        BuildContext context,
                        bool showValue,
                        Widget? child,
                      ) {
                        return showValue
                            ? Row(
                                children: [
                                  MultiDownloadButton(
                                    data: _songs
                                        .where(
                                          (element) => selectedItems
                                              .contains(element['id']),
                                        )
                                        .toList(),
                                    playlistName: widget.showName == null
                                        ? widget.playlistName[0].toUpperCase() +
                                            widget.playlistName.substring(1)
                                        : widget.showName![0].toUpperCase() +
                                            widget.showName!.substring(1),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      selectedItems.clear();
                                      selectMode.value = false;
                                    },
                                    icon: const Icon(Icons.clear_rounded),
                                  )
                                ],
                              )
                            : child!;
                      },
                    ),
                  ],
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
                            onDelete: (Map item) {
                              deleteLiked(item);
                            },
                            playlistName: widget.playlistName,
                            scrollController: _scrollController,
                          ),
                          AlbumsTab(
                            albums: _albums,
                            type: 'album',
                            offline: false,
                            playlistName: widget.playlistName,
                            sortedAlbumKeysList: _sortedAlbumKeysList,
                          ),
                          AlbumsTab(
                            albums: _artists,
                            type: 'artist',
                            offline: false,
                            playlistName: widget.playlistName,
                            sortedAlbumKeysList: _sortedArtistKeysList,
                          ),
                          AlbumsTab(
                            albums: _genres,
                            type: 'genre',
                            offline: false,
                            playlistName: widget.playlistName,
                            sortedAlbumKeysList: _sortedGenreKeysList,
                          ),
                        ],
                      ),
                floatingActionButton: ValueListenableBuilder(
                  valueListenable: _showShuffle,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).cardColor,
                    child: Icon(
                      Icons.shuffle_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      size: 24.0,
                    ),
                    onPressed: () {
                      if (_songs.isNotEmpty) {
                        PlayerInvoke.init(
                          songsList: _songs,
                          index: 0,
                          isOffline: false,
                          recommend: false,
                          shuffle: true,
                        );
                      }
                    },
                  ),
                  builder: (
                    BuildContext context,
                    bool showShuffle,
                    Widget? child,
                  ) {
                    return AnimatedSlide(
                      duration: const Duration(milliseconds: 300),
                      offset: showShuffle ? Offset.zero : const Offset(0, 2),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: showShuffle ? 1 : 0,
                        child: child,
                      ),
                    );
                  },
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
  final List songs;
  final String playlistName;
  final Function(Map item) onDelete;
  final ScrollController scrollController;
  const SongsTab({
    super.key,
    required this.songs,
    required this.onDelete,
    required this.playlistName,
    required this.scrollController,
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
    return (widget.songs.isEmpty)
        ? emptyScreen(
            context,
            3,
            'Nothing To',
            15.0,
            'Show Here',
            50,
            'Add Something',
            23.0,
          )
        : Column(
            children: [
              PlaylistHead(
                songsList: widget.songs,
                offline: false,
                fromDownloads: false,
              ),
              Expanded(
                child: ListView.builder(
                  controller: widget.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 10),
                  shrinkWrap: true,
                  itemCount: widget.songs.length,
                  itemExtent: 70.0,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder(
                      valueListenable: selectMode,
                      builder: (context, value, child) {
                        final bool selected =
                            selectedItems.contains(widget.songs[index]['id']);
                        return ListTile(
                          leading: Card(
                            elevation: 5,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox.square(
                              dimension: 50,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) =>
                                        const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/cover.jpg',
                                      ),
                                    ),
                                    imageUrl: widget.songs[index]['image']
                                        .toString()
                                        .replaceAll('http:', 'https:'),
                                    placeholder: (context, url) => const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/cover.jpg',
                                      ),
                                    ),
                                  ),
                                  if (selected)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            if (selectMode.value) {
                              selectMode.value = false;
                              if (selected) {
                                selectedItems.remove(
                                  widget.songs[index]['id'].toString(),
                                );
                                selectMode.value = true;
                                if (selectedItems.isEmpty) {
                                  selectMode.value = false;
                                }
                              } else {
                                selectedItems
                                    .add(widget.songs[index]['id'].toString());
                                selectMode.value = true;
                              }
                              setState(() {});
                            } else {
                              PlayerInvoke.init(
                                songsList: widget.songs,
                                index: index,
                                isOffline: false,
                                recommend: false,
                                playlistBox: widget.playlistName,
                              );
                            }
                          },
                          onLongPress: () {
                            selectMode.value = false;
                            if (selected) {
                              selectedItems
                                  .remove(widget.songs[index]['id'].toString());
                              selectMode.value = true;
                              if (selectedItems.isEmpty) {
                                selectMode.value = false;
                              }
                            } else {
                              selectedItems
                                  .add(widget.songs[index]['id'].toString());
                              selectMode.value = true;
                            }
                            setState(() {});
                          },
                          selected: selected,
                          selectedTileColor: Colors.white10,
                          title: Text(
                            '${widget.songs[index]['title']}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${widget.songs[index]['artist'] ?? 'Unknown'} - ${widget.songs[index]['album'] ?? 'Unknown'}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.playlistName != 'Favorite Songs')
                                LikeButton(
                                  mediaItem: null,
                                  data: widget.songs[index] as Map,
                                ),
                              DownloadButton(
                                data: widget.songs[index] as Map,
                                icon: 'download',
                              ),
                              SongTileTrailingMenu(
                                data: widget.songs[index] as Map,
                                isPlaylist: true,
                                deleteLiked: widget.onDelete,
                              ),
                            ],
                          ),
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

class AlbumsTab extends StatefulWidget {
  final Map<String, List> albums;
  final List sortedAlbumKeysList;
  // final String? tempPath;
  final String type;
  final bool offline;
  final String? playlistName;
  const AlbumsTab({
    super.key,
    required this.albums,
    required this.offline,
    required this.sortedAlbumKeysList,
    required this.type,
    this.playlistName,
    // this.tempPath,
  });

  @override
  State<AlbumsTab> createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.sortedAlbumKeysList.isEmpty
        ? emptyScreen(
            context,
            3,
            'Nothing To',
            15.0,
            'Show Here',
            50,
            'Add Something',
            23.0,
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 10.0),
            shrinkWrap: true,
            itemExtent: 70.0,
            itemCount: widget.sortedAlbumKeysList.length,
            itemBuilder: (context, index) {
              final List imageList = widget
                          .albums[widget.sortedAlbumKeysList[index]]!.length >=
                      4
                  ? widget.albums[widget.sortedAlbumKeysList[index]]!
                      .sublist(0, 4)
                  : widget.albums[widget.sortedAlbumKeysList[index]]!.sublist(
                      0,
                      widget.albums[widget.sortedAlbumKeysList[index]]!.length,
                    );
              return ListTile(
                leading: (widget.offline)
                    ? OfflineCollage(
                        imageList: imageList,
                        showGrid: widget.type == 'genre',
                        placeholderImage: widget.type == 'artist'
                            ? 'assets/images/artist.png'
                            : 'assets/images/album.png',
                      )
                    : Collage(
                        imageList: imageList,
                        showGrid: widget.type == 'genre',
                        placeholderImage: widget.type == 'artist'
                            ? 'assets/images/artist.png'
                            : 'assets/images/album.png',
                      ),
                title: Text(
                  '${widget.sortedAlbumKeysList[index]}',
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  widget.albums[widget.sortedAlbumKeysList[index]]!.length == 1
                      ? '${widget.albums[widget.sortedAlbumKeysList[index]]!.length} ${'song'}'
                      : '${widget.albums[widget.sortedAlbumKeysList[index]]!.length} song',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) =>
                          //widget.offline
                          // ? SongsList(
                          //     data: widget
                          //         .albums[widget.sortedAlbumKeysList[index]]!,
                          //     offline: widget.offline,
                          //   )
                          // :
                          LikedSongs(
                        playlistName: widget.playlistName!,
                        fromPlaylist: true,
                        showName: widget.sortedAlbumKeysList[index].toString(),
                        songs: widget.albums[widget.sortedAlbumKeysList[index]],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
