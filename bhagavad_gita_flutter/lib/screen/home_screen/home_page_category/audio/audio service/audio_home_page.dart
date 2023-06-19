import 'dart:io';
import 'dart:math';

import 'package:video_player/video_player.dart';

import '../CustomWidgets/custom_physics.dart';
import '../CustomWidgets/gradient_containers.dart';
import '../LocalMusic/downed_songs.dart';
import '../LocalMusic/downed_songs_desktop.dart';
import '../LocalMusic/favorite_songs.dart';
import '../playlists.dart';
import 'downloads.dart';
import 'miniplayer.dart';
import '../CustomWidgets/textinput_dialog.dart';

import '../saavn.dart';
import '../search.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AudioHomePage extends StatefulWidget {
  const AudioHomePage({super.key});

  @override
  State<AudioHomePage> createState() => _AudioHomePageState();
}

class _AudioHomePageState extends State<AudioHomePage> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  bool checked = false;

  String name =
      Hive.box('settings').get('name', defaultValue: 'Guest') as String;
  bool checkUpdate =
      Hive.box('settings').get('checkUpdate', defaultValue: false) as bool;
  bool autoBackup =
      Hive.box('settings').get('autoBackup', defaultValue: false) as bool;
  List sectionsToShow = Hive.box('settings').get(
    'sectionsToShow',
    defaultValue: ['Home', 'Top Charts', 'YouTube', 'Library'],
  ) as List;
  DateTime? backButtonPressTime;

  void callback() {
    sectionsToShow = Hive.box('settings').get(
      'sectionsToShow',
      defaultValue: ['Home', 'Top Charts', 'YouTube', 'Library'],
    ) as List;
    setState(() {});
  }

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    _pageController.jumpToPage(
      index,
    );
  }

  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return GradientContainer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: GradientContainer(
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  stretch: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.1),
                          ],
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset('assets/images/audiodrawer.gif',
                          height: double.infinity, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: const Text('My Music'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          MdiIcons.folderMusic,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (Platform.isWindows ||
                                      Platform.isLinux ||
                                      Platform.isMacOS)
                                  ? const DownloadedSongsDesktop()
                                  : const DownloadedSongs(
                                      showPlaylists: true,
                                    ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Favourite'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          MdiIcons.heart,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FavlistScreen()),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Download'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.download,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Downloads()),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Playlists'),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.playlist_play_rounded,
                          size: 26,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlaylistScreen()),
                          );

                          //  Navigator.pushNamed(context, '/playlists');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Row(
            children: [
              if (rotated)
                ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder:
                      (BuildContext context, int indexValue, Widget? child) {
                    return NavigationRail(
                      minWidth: 70.0,
                      groupAlignment: 0.0,
                      backgroundColor:
                          // Colors.transparent,
                          Theme.of(context).cardColor,
                      selectedIndex: indexValue,
                      onDestinationSelected: (int index) {
                        _onItemTapped(index);
                      },
                      labelType: screenWidth > 1050
                          ? NavigationRailLabelType.selected
                          : NavigationRailLabelType.none,
                      selectedLabelTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                      ),
                      selectedIconTheme: Theme.of(context).iconTheme.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      unselectedIconTheme: Theme.of(context).iconTheme,
                      useIndicator: screenWidth < 1050,
                      indicatorColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                      leading: Builder(
                        builder: (context) => Transform.rotate(
                          angle: 22 / 7 * 2,
                          child: IconButton(
                            icon: const Icon(
                              Icons.horizontal_split_rounded,
                            ),
                            // color: Theme.of(context).iconTheme.color,
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            tooltip: MaterialLocalizations.of(context)
                                .openAppDrawerTooltip,
                          ),
                        ),
                      ),
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_rounded),
                          label: Text('Home'),
                        ),

                        // if (sectionsToShow.contains('Settings'))
                        //   NavigationRailDestination(
                        //     icon: const Icon(Icons.settings_rounded),
                        //     label: Text(
                        //       AppLocalizations.of(context)!.settings,
                        //     ),
                        //    ),
                      ],
                    );
                  },
                ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const CustomPhysics(),
                        onPageChanged: (indx) {
                          _selectedIndex.value = indx;
                        },
                        controller: _pageController,
                        children: [
                          Stack(
                            children: [
                              //   checkVersion(),
                              NestedScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: _scrollController,
                                headerSliverBuilder: (
                                  BuildContext context,
                                  bool innerBoxScrolled,
                                ) {
                                  return <Widget>[
                                    SliverAppBar(
                                      expandedHeight: 135,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      // pinned: true,
                                      toolbarHeight: 65,
                                      // floating: true,
                                      automaticallyImplyLeading: false,
                                      flexibleSpace: LayoutBuilder(
                                        builder: (
                                          BuildContext context,
                                          BoxConstraints constraints,
                                        ) {
                                          return FlexibleSpaceBar(
                                            // collapseMode: CollapseMode.parallax,
                                            background: GestureDetector(
                                              onTap: () async {
                                                await showTextInputDialog(
                                                  context: context,
                                                  title: 'Name',
                                                  initialText: name,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  onSubmitted: (value) {
                                                    Hive.box('settings').put(
                                                      'name',
                                                      value.trim(),
                                                    );
                                                    name = value.trim();
                                                    Navigator.pop(context);
                                                  },
                                                );
                                                setState(() {});
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const SizedBox(
                                                    height: 60,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 15.0,
                                                        ),
                                                        child: Text(
                                                          'Search and Play Music',
                                                          style: TextStyle(
                                                            letterSpacing: 2,
                                                            color: Theme.of(
                                                              context,
                                                            )
                                                                .colorScheme
                                                                .secondary,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 15.0,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        ValueListenableBuilder(
                                                          valueListenable:
                                                              Hive.box(
                                                            'settings',
                                                          ).listenable(),
                                                          builder: (
                                                            BuildContext
                                                                context,
                                                            Box box,
                                                            Widget? child,
                                                          ) {
                                                            return Text(
                                                              (box.get('name') ==
                                                                          null ||
                                                                      box.get('name') ==
                                                                          '')
                                                                  ? 'you want to listen'
                                                                  : box
                                                                      .get(
                                                                        'name',
                                                                      )
                                                                      .split(
                                                                        ' ',
                                                                      )[0]
                                                                      .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                letterSpacing:
                                                                    2,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SliverAppBar(
                                      automaticallyImplyLeading: false,
                                      pinned: true,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      stretch: true,
                                      toolbarHeight: 65,
                                      title: Align(
                                        alignment: Alignment.centerRight,
                                        child: AnimatedBuilder(
                                          animation: _scrollController,
                                          builder: (context, child) {
                                            return GestureDetector(
                                              child: AnimatedContainer(
                                                width: (!_scrollController
                                                            .hasClients ||
                                                        _scrollController
                                                                // ignore: invalid_use_of_protected_member
                                                                .positions
                                                                .length >
                                                            1)
                                                    ? MediaQuery.of(context)
                                                        .size
                                                        .width
                                                    : max(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            _scrollController
                                                                .offset
                                                                .roundToDouble(),
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            (rotated ? 0 : 75),
                                                      ),
                                                height: 55.0,
                                                duration: const Duration(
                                                  milliseconds: 150,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                // margin: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.0,
                                                  ),
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 5.0,
                                                      offset: Offset(1.5, 1.5),
                                                      // shadow direction: bottom right
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Icon(
                                                      CupertinoIcons.search,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                    ),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      'SearchText',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .color,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SearchPage(
                                                    query: '',
                                                    fromHome: true,
                                                    autofocus: true,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              
                                   body: const SaavnHomePage(),
                              ),
                              if (!rotated)
                                Builder(
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 4.0,
                                    ),
                                    child: Transform.rotate(
                                      angle: 22 / 7 * 2,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.horizontal_split_rounded,
                                        ),
                                        // color: Theme.of(context).iconTheme.color,
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        tooltip:
                                            MaterialLocalizations.of(context)
                                                .openAppDrawerTooltip,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          // if (sectionsToShow.contains('Top Charts'))
                          // TopCharts(
                          //   pageController: _pageController,
                          // ),
                          //   const YouTube(),
                          //    const LibraryPage(),
                          // if (sectionsToShow.contains('Settings'))
                          //   NewSettingsPage(callback: callback),
                        ],
                      ),
                    ),
                    MiniPlayer()
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: rotated
        //     ? null
        //     : SafeArea(
        //         child: ValueListenableBuilder(
        //           valueListenable: _selectedIndex,
        //           builder:
        //               (BuildContext context, int indexValue, Widget? child) {
        //             return AnimatedContainer(
        //               duration: const Duration(milliseconds: 100),
        //               height: 60,
        //               child: SalomonBottomBar(
        //                 currentIndex: indexValue,
        //                 onTap: (index) {
        //                   _onItemTapped(index);
        //                 },
        //                 items: [
        //                   SalomonBottomBarItem(
        //                     icon: const Icon(Icons.home_rounded),
        //                     title: Text(AppLocalizations.of(context)!.home),
        //                     selectedColor:
        //                         Theme.of(context).colorScheme.secondary,
        //                   ),
        //                   if (sectionsToShow.contains('Top Charts'))
        //                     SalomonBottomBarItem(
        //                       icon: const Icon(Icons.trending_up_rounded),
        //                       title: Text(
        //                         AppLocalizations.of(context)!.topCharts,
        //                       ),
        //                       selectedColor:
        //                           Theme.of(context).colorScheme.secondary,
        //                     ),
        //                   SalomonBottomBarItem(
        //                     icon: const Icon(MdiIcons.youtube),
        //                     title: Text(AppLocalizations.of(context)!.youTube),
        //                     selectedColor:
        //                         Theme.of(context).colorScheme.secondary,
        //                   ),
        //                   SalomonBottomBarItem(
        //                     icon: const Icon(Icons.my_library_music_rounded),
        //                     title: Text(AppLocalizations.of(context)!.library),
        //                     selectedColor:
        //                         Theme.of(context).colorScheme.secondary,
        //                   ),
        //                   if (sectionsToShow.contains('Settings'))
        //                     SalomonBottomBarItem(
        //                       icon: const Icon(Icons.settings_rounded),
        //                       title:
        //                           Text(AppLocalizations.of(context)!.settings),
        //                       selectedColor:
        //                           Theme.of(context).colorScheme.secondary,
        //                     ),
        //                 ],
        //               ),
        //             );
        //           },
        //         ),
        //       ),
      ),
    );
  }
}
