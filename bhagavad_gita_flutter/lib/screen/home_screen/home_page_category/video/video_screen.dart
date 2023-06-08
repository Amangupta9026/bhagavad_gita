import 'package:bhagavad_gita_flutter/widget/search_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../widget/app_bar_header.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Video',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 60),
          child: Column(
            children: [
              Container(
                color: backgroundColor,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 8, 8, 15),
                  child: InkWell(onTap: null, child: SearchItemTextField()),
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        Row(children: [
                          Image.asset(
                            'assets/images/board3.jpg',
                            width: 60,
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            children: [
                              Text(
                                'Bhagavad Gita Chapter 1',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.play_circle_outline_rounded,
                              size: 40, color: Colors.black)
                        ]),
                        const Divider(
                          color: Colors.grey,
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
