import 'package:audio_service/audio_service.dart';
import '../add_mediaitem_to_queue.dart';
import '../mediaitem_converter.dart';
import '../audio service/song_list.dart';

import '../search.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SongTileTrailingMenu extends StatefulWidget {
  final Map data;
  final bool isPlaylist;
  final Function(Map)? deleteLiked;
  const SongTileTrailingMenu({
    super.key,
    required this.data,
    this.isPlaylist = false,
    this.deleteLiked,
  });

  @override
  State<SongTileTrailingMenu> createState() => _SongTileTrailingMenuState();
}

class _SongTileTrailingMenuState extends State<SongTileTrailingMenu> {
  @override
  Widget build(BuildContext context) {
    final MediaItem mediaItem = MediaItemConverter.mapToMediaItem(widget.data);
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        if (widget.isPlaylist && widget.deleteLiked != null)
          const PopupMenuItem(
            value: 6,
            child: Row(
              children: [
                Icon(
                  Icons.delete_rounded,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Remove',
                ),
              ],
            ),
          ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.playlist_play_rounded,
                color: Theme.of(context).iconTheme.color,
                size: 26.0,
              ),
              const SizedBox(width: 10.0),
              const Text('PlayNext'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.queue_music_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('AddToQueue'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.playlist_add_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('AddToPlaylist'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Icon(
                Icons.album_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('ViewAlbum'),
            ],
          ),
        ),
        if (mediaItem.artist != null)
          ...mediaItem.artist.toString().split(', ').map(
                (artist) => PopupMenuItem(
                  value: artist,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          '${'ViewArtist'} ($artist)',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(
                Icons.share_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('Share'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 3:
            Share.share(widget.data['perma_url'].toString());
            break;

          case 4:
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) => SongsListPage(
                  listItem: {
                    'type': 'album',
                    'id': mediaItem.extras?['album_id'],
                    'title': mediaItem.album,
                    'image': mediaItem.artUri,
                  },
                ),
              ),
            );
            break;
          case 6:
            widget.deleteLiked!(widget.data);
            break;
          case 0:
            //  AddToPlaylist().addToPlaylist(context, mediaItem);
            break;
          case 1:
            addToNowPlaying(context: context, mediaItem: mediaItem);
            break;
          case 2:
            playNext(mediaItem, context);
            break;
          default:
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     opaque: false,
            //     pageBuilder: (_, __, ___) => AlbumSearchPage(
            //       query: value.toString(),
            //       type: 'Artists',
            //     ),
            //   ),
            // );
            break;
        }
      },
    );
  }
}

class YtSongTileTrailingMenu extends StatefulWidget {
  final Map data;
  const YtSongTileTrailingMenu({super.key, required this.data});

  @override
  State<YtSongTileTrailingMenu> createState() => _YtSongTileTrailingMenuState();
}

class _YtSongTileTrailingMenuState extends State<YtSongTileTrailingMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                CupertinoIcons.search,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                'SearchHome',
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.playlist_play_rounded,
                color: Theme.of(context).iconTheme.color,
                size: 26.0,
              ),
              const SizedBox(width: 10.0),
              const Text('PlayNext'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.queue_music_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('AddToQueue'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(
                Icons.playlist_add_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('AddToPlaylist'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Icon(
                Icons.video_library_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('WatchVideo'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 5,
          child: Row(
            children: [
              Icon(
                Icons.share_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('Share'),
            ],
          ),
        ),
      ],
      onSelected: (int? value) {
        if (value == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                query: widget.data['title'].toString(),
              ),
            ),
          );
        }
        // if (value == 1 || value == 2 || value == 3) {
        //   YouTubeServices()
        //       .formatVideoFromId(
        //     id: widget.data['id'].toString(),
        //     data: widget.data,
        //   )
        //       .then((songMap) {
        //     final MediaItem mediaItem =
        //         MediaItemConverter.mapToMediaItem(songMap!);
        //     if (value == 1) {
        //       playNext(mediaItem, context);
        //     }
        //     if (value == 2) {
        //       addToNowPlaying(context: context, mediaItem: mediaItem);
        //     }
        //     if (value == 3) {
        //       AddToPlaylist().addToPlaylist(context, mediaItem);
        //     }
        //   });
        // }
        if (value == 4) {
          launchUrl(
            Uri.parse('https://youtube.com/watch?v=${widget.data["id"]}'),
            mode: LaunchMode.externalApplication,
          );
        }
        if (value == 5) {
          Share.share('https://youtube.com/watch?v=${widget.data["id"]}');
        }
      },
    );
  }
}
