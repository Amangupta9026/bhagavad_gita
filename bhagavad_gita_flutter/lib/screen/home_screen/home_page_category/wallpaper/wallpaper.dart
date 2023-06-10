import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

  CachedNetworkImage imagedata(width, height, imageUrl) {
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  CachedNetworkImage image = imagedata(
                    width,
                    height,
                    "https://m.media-amazon.com/images/I/71eKV2BYQrL._AC_UF894,1000_QL80_.jpg",
                  );
                  context.pushNamed(RouteNames.wallpaperImage,
                      extra:
                          'https://m.media-amazon.com/images/I/71eKV2BYQrL._AC_UF894,1000_QL80_.jpg');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => WallpaperImage(
                  //               image: image,
                  //               imageUrl: imageUrl,
                  //             )));
                },
                child: imagedata(
                  width,
                  height,
                  "https://m.media-amazon.com/images/I/71eKV2BYQrL._AC_UF894,1000_QL80_.jpg",
                ),
              );
            },
          ),
        ]),
      )),
    );
  }
}
