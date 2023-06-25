import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/colors.dart';

class ShimmerProgressWidget extends StatelessWidget {
  const ShimmerProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
        baseColor: primaryColor,
        //Colors.grey[300]!,
        highlightColor: lightPinkColor,

        child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
            shrinkWrap: true,
            itemCount: 6,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                child: Container(
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(9),
                                      topLeft: Radius.circular(9)),
                                  child: CachedNetworkImage(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.190,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          'https://picsum.photos/250?image=9',
                                      placeholder: (context, url) => Center(
                                            child: Image.asset(
                                              'assets/images/board2.jpg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.190,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            'assets/images/board2.jpg',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.190,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[700]!,
                                    ),
                                    child: const Text(
                                      'Bhagavad Gita Bhagavad Gita Bhagavad Gita Bhagavad Gita Bhagavad Gita',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                    '- - - - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                        ]),
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
