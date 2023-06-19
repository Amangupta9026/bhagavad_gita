// ignore_for_file: use_build_context_synchronously

import 'dart:io';


import 'CustomWidgets/horizontal_albumlist.dart';
import 'CustomWidgets/like_button.dart';
import 'CustomWidgets/snackbar.dart';
import 'CustomWidgets/song_tile_trailing_menu.dart';
import 'api.dart';

import 'audio service/audioplayer.dart';
import 'extensions.dart';
import 'format.dart';
import 'image_resolution_modifier.dart';
import 'audio service/song_list.dart';
import 'liked.dart';
import 'artists.dart';
import 'audio service/player_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'CustomWidgets/collage.dart';
import 'CustomWidgets/horizontal_albumlist_separated.dart';
import 'CustomWidgets/on_hover.dart';

bool fetched = false;
List preferredLanguage = Hive.box('settings')
    .get('preferredLanguage', defaultValue: ['Hindi']) as List;
List likedRadio =
    Hive.box('settings').get('likedRadio', defaultValue: []) as List;
Map data = {};
//Hive.box('cache').get('homepage', defaultValue: {}) as Map;
List lists = ['recent', 'playlist', ...?data['collections'] as List?];

class SaavnHomePage extends StatefulWidget {
  const SaavnHomePage({super.key});

  @override
  State<SaavnHomePage> createState() => _SaavnHomePageState();
}

class _SaavnHomePageState extends State<SaavnHomePage>
    with AutomaticKeepAliveClientMixin<SaavnHomePage> {
  List recentList = [];
  // Hive.box('cache').get('recentSongs', defaultValue: []) as List;
  Map likedArtists =
      Hive.box('settings').get('likedArtists', defaultValue: {}) as Map;
  List blacklistedHomeSections = Hive.box('settings')
      .get('blacklistedHomeSections', defaultValue: []) as List;
  List playlistNames =
      Hive.box('settings').get('playlistNames')?.toList() as List? ??
          ['Favorite Songs'];
  Map playlistDetails =
      Hive.box('settings').get('playlistDetails', defaultValue: {}) as Map;
  int recentIndex = 0;
  int playlistIndex = 1;

  Future<void> getHomePageData() async {
    Map recievedData = await SaavnAPI().fetchHomePageData();
    if (recievedData.isNotEmpty) {
     // Hive.box('cache').put('homepage', recievedData);
      data = recievedData;
      lists = ['recent', 'playlist', ...?data['collections'] as List?];
      lists.insert((lists.length / 2).round(), 'likedArtists');
    }
    setState(() {});
    recievedData = await FormatResponse.formatPromoLists(data);
    if (recievedData.isNotEmpty) {
    //  Hive.box('cache').put('homepage', recievedData);
      data = recievedData;
      lists = ['recent', 'playlist', ...?data['collections'] as List?];
      lists.insert((lists.length / 2).round(), 'likedArtists');
    }
    setState(() {});
  }

  String getSubTitle(Map item) {
    final type = item['type'];
    switch (type) {
      case 'charts':
        return '';
      case 'radio_station':
        return 'Radio • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle']?.toString().unescape()}';
      case 'playlist':
        return 'Playlist • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle'].toString().unescape()}';
      case 'song':
        return 'Single • ${item['artist']?.toString().unescape()}';
      case 'mix':
        return 'Mix • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle'].toString().unescape()}';
      case 'show':
        return 'Podcast • ${(item['subtitle']?.toString() ?? '').isEmpty ? 'JioSaavn' : item['subtitle'].toString().unescape()}';
      case 'album':
        final artists = item['more_info']?['artistMap']?['artists']
            .map((artist) => artist['name'])
            .toList();
        if (artists != null) {
          return 'Album • ${artists?.join(', ')?.toString().unescape()}';
        } else if (item['subtitle'] != null && item['subtitle'] != '') {
          return 'Album • ${item['subtitle']?.toString().unescape()}';
        }
        return 'Album';
      default:
        final artists = item['more_info']?['artistMap']?['artists']
            .map((artist) => artist['name'])
            .toList();
        return artists?.join(', ')?.toString().unescape() ?? '';
    }
  }

  int likedCount() {
    return Hive.box('Favorite Songs').length;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!fetched) {
      getHomePageData();
      fetched = true;
    }
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    if (playlistNames.length >= 3) {
      recentIndex = 0;
      playlistIndex = 1;
    } else {
      recentIndex = 1;
      playlistIndex = 0;
    }
    return (data.isEmpty && recentList.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            itemCount: data.isEmpty ? 2 : lists.length,
            itemBuilder: (context, idx) {
              if (idx == recentIndex) {
                return (recentList.isEmpty ||
                        !(Hive.box('settings')
                            .get('showRecent', defaultValue: true) as bool))
                    ? const SizedBox()
                    : Column(
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 0, 5),
                                  child: Text(
                                    'Last Session',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/recent');
                            },
                          ),
                          HorizontalAlbumsListSeparated(
                            songsList: recentList,
                            onTap: (int idx) {
                              PlayerInvoke.init(
                                songsList: [recentList[idx]],
                                index: 0,
                                isOffline: false,
                              );
                            },
                          ),
                        ],
                      );
              }
              if (idx == playlistIndex) {
                return (playlistNames.isEmpty ||
                        !(Hive.box('settings')
                            .get('showPlaylist', defaultValue: true) as bool) ||
                        (playlistNames.length == 1 &&
                            playlistNames.first == 'Favorite Songs' &&
                            likedCount() == 0))
                    ? const SizedBox()
                    : Column(
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 5),
                                  child: Text(
                                    'Your Playlists',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/playlists');
                            },
                          ),
                          SizedBox(
                            height: boxSize + 15,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: playlistNames.length,
                              itemBuilder: (context, index) {
                                final String name =
                                    playlistNames[index].toString();
                                final String showName =
                                    playlistDetails.containsKey(name)
                                        ? playlistDetails[name]['name']
                                                ?.toString() ??
                                            name
                                        : name;
                                final String? subtitle = playlistDetails[
                                                name] ==
                                            null ||
                                        playlistDetails[name]['count'] ==
                                            null ||
                                        playlistDetails[name]['count'] == 0
                                    ? null
                                    : '${playlistDetails[name]['count']} Songs';
                                return GestureDetector(
                                  child: SizedBox(
                                    width: boxSize - 20,
                                    child: HoverBox(
                                      child: (playlistDetails[name] == null ||
                                              playlistDetails[name]
                                                      ['imagesList'] ==
                                                  null ||
                                              (playlistDetails[name]
                                                      ['imagesList'] as List)
                                                  .isEmpty)
                                          ? Card(
                                              elevation: 5,
                                              color: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.0,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: name == 'Favorite Songs'
                                                  ? const Image(
                                                      image: AssetImage(
                                                        'assets/images/cover.jpg',
                                                      ),
                                                    )
                                                  : const Image(
                                                      image: AssetImage(
                                                        'assets/images/album.png',
                                                      ),
                                                    ),
                                            )
                                          : Collage(
                                              borderRadius: 10.0,
                                              imageList: playlistDetails[name]
                                                  ['imagesList'] as List,
                                              showGrid: true,
                                              placeholderImage:
                                                  'assets/images/cover.jpg',
                                            ),
                                      builder: ({
                                        required BuildContext context,
                                        required bool isHover,
                                        Widget? child,
                                      }) {
                                        return Card(
                                          color: isHover
                                              ? null
                                              : Colors.transparent,
                                          elevation: 0,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            children: [
                                              SizedBox.square(
                                                dimension: isHover
                                                    ? boxSize - 25
                                                    : boxSize - 30,
                                                child: child,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      showName,
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    if (subtitle != null &&
                                                        subtitle.isNotEmpty)
                                                      Text(
                                                        subtitle,
                                                        textAlign:
                                                            TextAlign.center,
                                                        softWrap: false,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .color,
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  onTap: () async {
                                    await Hive.openBox(name);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LikedSongs(
                                          playlistName: name,
                                          showName: playlistDetails
                                                  .containsKey(name)
                                              ? playlistDetails[name]['name']
                                                      ?.toString() ??
                                                  name
                                              : name,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      );
              }
              if (lists[idx] == 'likedArtists') {
                final List likedArtistsList = likedArtists.values.toList();
                return likedArtists.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 0, 5),
                                child: Text(
                                  'Liked Artists',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          HorizontalAlbumsList(
                            songsList: likedArtistsList,
                            onTap: (int idx) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (_, __, ___) => ArtistSearchPage(
                                    data: likedArtistsList[idx] as Map,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
              }
              return (data[lists[idx]] == null ||
                      blacklistedHomeSections.contains(
                        data['modules'][lists[idx]]?['title']
                            ?.toString()
                            .toLowerCase(),
                      ))
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: Row(
                            children: [
                              Text(
                                data['modules'][lists[idx]]?['title']
                                        ?.toString()
                                        .unescape() ??
                                    '',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.block_rounded,
                                  color: Theme.of(context).disabledColor,
                                  size: 18,
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        title: const Text(
                                          'Not Interested',
                                        ),
                                        content: const Text(
                                            'Are you sure you want to hide this section ?'),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'No',
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              blacklistedHomeSections.add(
                                                data['modules'][lists[idx]]
                                                        ?['title']
                                                    ?.toString()
                                                    .toLowerCase(),
                                              );
                                              Hive.box('settings').put(
                                                'blacklistedHomeSections',
                                                blacklistedHomeSections,
                                              );
                                              setState(() {});
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: boxSize + 15,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: data['modules'][lists[idx]]?['title']
                                        ?.toString() ==
                                    'Radio Stations'
                                ? (data[lists[idx]] as List).length +
                                    likedRadio.length
                                : (data[lists[idx]] as List).length,
                            itemBuilder: (context, index) {
                              Map item;
                              if (data['modules'][lists[idx]]?['title']
                                      ?.toString() ==
                                  'Radio Stations') {
                                index < likedRadio.length
                                    ? item = likedRadio[index] as Map
                                    : item = data[lists[idx]]
                                        [index - likedRadio.length] as Map;
                              } else {
                                item = data[lists[idx]][index] as Map;
                              }
                              final currentSongList = data[lists[idx]]
                                  .where((e) => e['type'] == 'song')
                                  .toList();
                              final subTitle = getSubTitle(item);
                              item['subTitle'] = subTitle;
                              if (item.isEmpty) return const SizedBox();
                              return GestureDetector(
                                onLongPress: () {
                                  Feedback.forLongPress(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return InteractiveViewer(
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              contentPadding: EdgeInsets.zero,
                                              content: Card(
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    item['type'] ==
                                                            'radio_station'
                                                        ? 1000.0
                                                        : 15.0,
                                                  ),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, _, __) =>
                                                          const Image(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/cover.jpg',
                                                    ),
                                                  ),
                                                  imageUrl: getImageUrl(
                                                    item['image'].toString(),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Image(
                                                    fit: BoxFit.cover,
                                                    image: (item['type'] ==
                                                                'playlist' ||
                                                            item['type'] ==
                                                                'album')
                                                        ? const AssetImage(
                                                            'assets/images/album.png',
                                                          )
                                                        : item['type'] ==
                                                                'artist'
                                                            ? const AssetImage(
                                                                'assets/images/artist.png',
                                                              )
                                                            : const AssetImage(
                                                                'assets/images/cover.jpg',
                                                              ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                onTap: () {
                                  if (item['type'] == 'radio_station') {
                                    ShowSnackBar().showSnackBar(
                                      context,
                                      'Connecting Radio',
                                      duration: const Duration(seconds: 2),
                                    );
                                    SaavnAPI()
                                        .createRadio(
                                      names: item['more_info']
                                                      ['featured_station_type']
                                                  .toString() ==
                                              'artist'
                                          ? [
                                              item['more_info']['query']
                                                  .toString()
                                            ]
                                          : [item['id'].toString()],
                                      language: item['more_info']['language']
                                              ?.toString() ??
                                          'hindi',
                                      stationType: item['more_info']
                                              ['featured_station_type']
                                          .toString(),
                                    )
                                        .then((value) {
                                      if (value != null) {
                                        SaavnAPI()
                                            .getRadioSongs(stationId: value)
                                            .then((value) {
                                          PlayerInvoke.init(
                                            songsList: value,
                                            index: 0,
                                            isOffline: false,
                                            shuffle: true,
                                          );
                                          Navigator.pushNamed(
                                            context,
                                            '/player',
                                          );
                                        });
                                      }
                                    });
                                  } else {
                                    if (item['type'] == 'song') {
                                      PlayerInvoke.init(
                                        songsList: currentSongList as List,
                                        index: currentSongList.indexWhere(
                                          (e) => e['id'] == item['id'],
                                        ),
                                        isOffline: false,
                                      );
                                    }
                                    item['type'] == 'song'
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PlayScreen()),
                                          )
                                        : Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (_, __, ___) =>
                                                  SongsListPage(
                                                listItem: item,
                                              ),
                                            ),
                                          );
                                  }
                                },
                                child: SizedBox(
                                  width: boxSize - 30,
                                  child: HoverBox(
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          item['type'] == 'radio_station'
                                              ? 1000.0
                                              : 10.0,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        errorWidget: (context, _, __) =>
                                            const Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/cover.jpg',
                                          ),
                                        ),
                                        imageUrl: getImageUrl(
                                          item['image'].toString(),
                                        ),
                                        placeholder: (context, url) => Image(
                                          fit: BoxFit.cover,
                                          image: (item['type'] == 'playlist' ||
                                                  item['type'] == 'album')
                                              ? const AssetImage(
                                                  'assets/images/album.png',
                                                )
                                              : item['type'] == 'artist'
                                                  ? const AssetImage(
                                                      'assets/images/artist.png',
                                                    )
                                                  : const AssetImage(
                                                      'assets/images/cover.jpg',
                                                    ),
                                        ),
                                      ),
                                    ),
                                    builder: ({
                                      required BuildContext context,
                                      required bool isHover,
                                      Widget? child,
                                    }) {
                                      return Card(
                                        color:
                                            isHover ? null : Colors.transparent,
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox.square(
                                                  dimension: isHover
                                                      ? boxSize - 25
                                                      : boxSize - 30,
                                                  child: child,
                                                ),
                                                if (isHover &&
                                                    (item['type'] == 'song' ||
                                                        item['type'] ==
                                                            'radio_station'))
                                                  Positioned.fill(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                        4.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          item['type'] ==
                                                                  'radio_station'
                                                              ? 1000.0
                                                              : 10.0,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.black87,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              1000.0,
                                                            ),
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .play_arrow_rounded,
                                                            size: 50.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (item['type'] ==
                                                        'radio_station' &&
                                                    (Platform.isAndroid ||
                                                        Platform.isIOS ||
                                                        isHover))
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      icon: likedRadio
                                                              .contains(item)
                                                          ? const Icon(
                                                              Icons
                                                                  .favorite_rounded,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border_rounded,
                                                            ),
                                                      tooltip: likedRadio
                                                              .contains(item)
                                                          ? 'Unlike'
                                                          : 'Like',
                                                      onPressed: () {
                                                        likedRadio
                                                                .contains(item)
                                                            ? likedRadio
                                                                .remove(item)
                                                            : likedRadio
                                                                .add(item);
                                                        Hive.box('settings')
                                                            .put(
                                                          'likedRadio',
                                                          likedRadio,
                                                        );
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                if (item['type'] == 'song' ||
                                                    item['duration'] != null)
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        if (isHover)
                                                          LikeButton(
                                                            mediaItem: null,
                                                            data: item,
                                                          ),
                                                        SongTileTrailingMenu(
                                                          data: item,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    item['title']
                                                            ?.toString()
                                                            .unescape() ??
                                                        '',
                                                    textAlign: TextAlign.center,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  if (subTitle != '')
                                                    Text(
                                                      subTitle,
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .color,
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          );
  }
}
