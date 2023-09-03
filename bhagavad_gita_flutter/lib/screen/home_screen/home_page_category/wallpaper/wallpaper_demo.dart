import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes_names.dart';
import '../../../../utils/file_collection.dart';
import '../../../../widget/app_bar_header.dart';

class WallpaperDemo extends StatelessWidget {
  const WallpaperDemo({Key? key}) : super(key: key);

  final double? width = 300;
  final double? height = 200;

  imagedata(width, height, imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Image.asset(
        "assets/images/board4.jpg",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      placeholder: (context, url) => Image.asset(
        "assets/images/board4.jpg",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Wallpaper',
        ),
      ),
      body: Scrollbar(
        child: PaginateFirestore(
          itemBuilderType:
              PaginateBuilderType.gridView, //Change types accordingly
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, documentSnapshots, index) {
            final data = documentSnapshots[index].data() as Map?;
            return InkWell(
              onTap: () {
                context.pushNamed(
                  RouteNames.wallpaperImage,
                  pathParameters: {
                    'url': data?['url'],
                  },
                );
              },
              child: imagedata(
                width,
                height,
                data?['url'],
              ),
            );
          },
          // orderBy is compulsory to enable pagination
          query: FirebaseFirestore.instance
              .collection('wallpaper')
              .orderBy('server_time', descending: true),
          itemsPerPage: 10,
          // to fetch real-time data
          // isLive: true,
          allowImplicitScrolling: true,
          bottomLoader: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
