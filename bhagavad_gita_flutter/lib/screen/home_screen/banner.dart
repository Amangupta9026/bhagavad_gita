import 'package:carousel_animations/carousel_animations.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  HomeBanner({super.key});

  final List<String> imageList = [
    "assets/images/board2.jpg",
    "assets/images/board3.jpg",
    "assets/images/board5.jpg",
    "assets/images/board6.jpg",
    "assets/images/board7.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.asset(
            imageList[index],
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
        autoplay: true,
        itemCount: imageList.length,
        scrollDirection: Axis.horizontal,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.white,
            color: Colors.grey,
            size: 8,
            activeSize: 8,
          ),
        ),
        viewportFraction: 1,
        control: null,
      ),
    );
  }
}
