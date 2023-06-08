import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:bhagavad_gita_flutter/widget/search_widget.dart';
import 'package:go_router/go_router.dart';

class EbookScreen extends StatelessWidget {
  const EbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarHeader(
            text: 'E-Books',
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 15),
                  child: InkWell(
                      onTap: () => context.pushNamed(RouteNames.ebook),
                      child: const SearchItemTextField()),
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(
                            RouteNames.ebookDetail,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[500]!),
                          ),
                          child: Column(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(9),
                                              topLeft: Radius.circular(9)),
                                          child: Image.asset(
                                            'assets/images/board3.jpg',
                                            //ebookList[index].image,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: primaryLightColor,
                                          ),
                                          child: const Text(
                                            'Bhagavad Gita',
                                            //ebookList[index].title,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                            'श्रीमद्भगवद्‌गीता हिन्दुओं के पवित्रतम ग्रन्थों में से एक है। महाभारत के अनुसार कुरुक्षेत्र युद्ध में भगवान श्री कृष्ण ने गीता का सन्देश अर्जुन को सुनाया था।',
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: textColor,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        )));
  }
}
