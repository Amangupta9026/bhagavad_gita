import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/colors.dart';
import '../../../../widget/shimmar_progress_widget.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

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
    double? width = 300;
    double? height = 200;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Wallpaper',
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryLightColor, lightPinkColor],
        )),
        child: SafeArea(
            child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('wallpaper')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                final data = snapshot.data?.docs;
                if (!snapshot.hasData) {
                  return const ShimmerProgressWidget();
                }

                return Column(children: [
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          context.pushNamed(
                            RouteNames.wallpaperImage,
                            pathParameters: {
                              'url': data?[index]['url'],
                            },
                          );
                        },
                        child: imagedata(
                          width,
                          height,
                          data?[index]['url'],
                        ),
                      );
                    },
                  ),
                ]);
              }),
        )),
      ),
    );
  }
}
