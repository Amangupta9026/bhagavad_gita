// ignore_for_file: use_build_context_synchronously

import '../CustomWidgets/snackbar.dart';
import '../CustomWidgets/textinput_dialog.dart';
import '../audio_query.dart';

import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'downed_songs.dart';

class LocalPlaylists extends StatefulWidget {
  final List<PlaylistModel> playlistDetails;
  final OfflineAudioQuery offlineAudioQuery;
  const LocalPlaylists({
    super.key,
    required this.playlistDetails,
    required this.offlineAudioQuery,
  });
  @override
  State<LocalPlaylists> createState() => _LocalPlaylistsState();
}

class _LocalPlaylistsState extends State<LocalPlaylists> {
  List<PlaylistModel> playlistDetails = [];
  @override
  Widget build(BuildContext context) {
    if (playlistDetails.isEmpty) {
      playlistDetails = widget.playlistDetails;
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          ListTile(
            title: const Text('createPlaylist'),
            leading: Card(
              elevation: 0,
              color: Colors.transparent,
              child: SizedBox.square(
                dimension: 50,
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
            onTap: () async {
              await showTextInputDialog(
                context: context,
                title: 'CreateNewPlaylist',
                initialText: '',
                keyboardType: TextInputType.name,
                onSubmitted: (String value) async {
                  if (value.trim() != '') {
                    Navigator.pop(context);
                    await widget.offlineAudioQuery.createPlaylist(
                      name: value,
                    );
                    widget.offlineAudioQuery.getPlaylists().then((value) {
                      playlistDetails = value;
                      setState(() {});
                    });
                  }
                },
              );
              setState(() {});
            },
          ),
          if (playlistDetails.isEmpty)
            const SizedBox()
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: playlistDetails.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: QueryArtworkWidget(
                      id: playlistDetails[index].id,
                      type: ArtworkType.PLAYLIST,
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(7.0),
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: const Image(
                          fit: BoxFit.cover,
                          height: 50.0,
                          width: 50.0,
                          image: AssetImage('assets/images/cover.jpg'),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    playlistDetails[index].playlist,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${playlistDetails[index].numOfSongs} ${'Songs'}',
                  ),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    onSelected: (int? value) async {
                      if (value == 0) {
                        if (await widget.offlineAudioQuery.removePlaylist(
                          playlistId: playlistDetails[index].id,
                        )) {
                          ShowSnackBar().showSnackBar(
                            context,
                            '${'Deleted'} ${playlistDetails[index].playlist}',
                          );
                          playlistDetails.removeAt(index);
                          setState(() {});
                        } else {
                          ShowSnackBar().showSnackBar(
                            context,
                            'FailedDelete',
                          );
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded),
                            SizedBox(width: 10.0),
                            Text(
                              'Delete',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final songs =
                        await widget.offlineAudioQuery.getPlaylistSongs(
                      playlistDetails[index].id,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadedSongs(
                          title: playlistDetails[index].playlist,
                          cachedSongs: songs,
                          playlistId: playlistDetails[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }
}
