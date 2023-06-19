// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import '../audio service/miniplayer.dart';
import '../CustomWidgets/collage.dart';
import '../CustomWidgets/gradient_containers.dart';

import '../CustomWidgets/snackbar.dart';
import '../LocalMusic/import_export_playlist.dart';
import '../liked.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class FavlistScreen extends StatefulWidget {
  const FavlistScreen({super.key});

  @override
  State<FavlistScreen> createState() => _FavlistScreenState();
}

class _FavlistScreenState extends State<FavlistScreen> {
  final Box settingsBox = Hive.box('settings');
  final List playlistNames =
      Hive.box('settings').get('playlistNames')?.toList() as List? ??
          ['Favorite Songs'];
  Map playlistDetails =
      Hive.box('settings').get('playlistDetails', defaultValue: {}) as Map;
  @override
  Widget build(BuildContext context) {
    if (!playlistNames.contains('Favorite Songs')) {
      playlistNames.insert(0, 'Favorite Songs');
      settingsBox.put('playlistNames', playlistNames);
    }

    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text(
                  'Favorite Songs',
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.secondary,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    //
                    ValueListenableBuilder(
                      valueListenable: settingsBox.listenable(),
                      builder: (
                        BuildContext context,
                        Box box,
                        Widget? child,
                      ) {
                        final List playlistNamesValue = box.get(
                              'playlistNames',
                              defaultValue: ['Favorite Songs'],
                            )?.toList() as List? ??
                            ['Favorite Songs'];
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: playlistNamesValue.length,
                          itemBuilder: (context, index) {
                            final String name =
                                playlistNamesValue[index].toString();
                            final String showName = playlistDetails
                                    .containsKey(name)
                                ? playlistDetails[name]['name']?.toString() ??
                                    name
                                : name;

                            if (showName != 'Favorite Songs') {
                              log('Favorite');
                              return null;
                            }
                            return ListTile(
                              leading: (playlistDetails[name] == null ||
                                      playlistDetails[name]['imagesList'] ==
                                          null ||
                                      (playlistDetails[name]['imagesList']
                                              as List)
                                          .isEmpty)
                                  ? Card(
                                      elevation: 5,
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
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
                                      ),
                                    )
                                  : Collage(
                                      imageList: playlistDetails[name]
                                          ['imagesList'] as List,
                                      showGrid: true,
                                      placeholderImage:
                                          'assets/images/cover.jpg',
                                    ),
                              title: Text(
                                showName,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: playlistDetails[name] == null ||
                                      playlistDetails[name]['count'] == null ||
                                      playlistDetails[name]['count'] == 0
                                  ? null
                                  : Text(
                                      '${playlistDetails[name]['count']} ${'Songs'}',
                                    ),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert_rounded),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                onSelected: (int? value) async {
                                  if (value == 1) {
                                    exportPlaylist(
                                      context,
                                      name,
                                      playlistDetails.containsKey(name)
                                          ? playlistDetails[name]['name']
                                                  ?.toString() ??
                                              name
                                          : name,
                                    );
                                  }
                                  if (value == 2) {
                                    sharePlaylist(
                                      context,
                                      name,
                                      playlistDetails.containsKey(name)
                                          ? playlistDetails[name]['name']
                                                  ?.toString() ??
                                              name
                                          : name,
                                    );
                                  }
                                  if (value == 0) {
                                    ShowSnackBar().showSnackBar(
                                      context,
                                      'Deleted $showName',
                                    );
                                    playlistDetails.remove(name);
                                    await settingsBox.put(
                                      'playlistDetails',
                                      playlistDetails,
                                    );
                                    await playlistNames.removeAt(index);
                                    await settingsBox.put(
                                      'playlistNames',
                                      playlistNames,
                                    );
                                    await Hive.openBox(name);
                                    await Hive.box(name).deleteFromDisk();
                                  }
                                  if (value == 3) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final controller =
                                            TextEditingController(
                                          text: showName,
                                        );
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Rename',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Icon(Icons.exposure_rounded),
                                        SizedBox(width: 10.0),
                                        Text(
                                          'Export',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Row(
                                      children: [
                                        Icon(Icons.share),
                                        SizedBox(width: 10.0),
                                        Text(
                                          'Share',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                await Hive.openBox(name);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LikedSongs(
                                      playlistName: name,
                                      showName:
                                          playlistDetails.containsKey(name)
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
                        );
                      },
                    )
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
