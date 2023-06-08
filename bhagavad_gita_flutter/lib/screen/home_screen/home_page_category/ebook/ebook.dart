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
        backgroundColor: backgroundColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarHeader(
            text: 'E-Books',
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 15),
                  child: InkWell(
                      onTap: () => context.pushNamed(RouteNames.ebook),
                      child: const SearchItemTextField()),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryLightColor),
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
                                        Image.asset(
                                          'assets/images/board3.jpg',
                                          //ebookList[index].image,

                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                        ),
                                      ],
                                    ),
                                  ),
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
                                          padding: const EdgeInsets.all(7),
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
                                            'Bhagavad Gita is a part of the 5th Veda (written by Vedavyasa - ancient Indian saint) and Indian Epic - Mahabharata. It was narrated for the first time in the battle of Kurukshetra, by Lord Krishna to Arjun. The Bhagavad Gita, also referred to as Gita, is a 700–verse Dharmic scripture that is part of the ancient Sanskrit epic Mahabharata. This scripture contains a conversation between Pandava prince Arjuna and his guide Krishna on a variety of philosophical issues. Faced with a fratricidal war, a despondent Arjuna turns to his charioteer Krishna for counsel on the battlefield. Krishna, through the course of the Bhagavad Gita, imparts to Arjuna wisdom, the path to devotion, and the doctrine of selfless action. The Bhagavad Gita upholds the essence and the philosophical tradition of the Upanishads. However, unlike the rigorous monism of the Upanishads, the Bhagavad Gita also integrates dualism and theism.',
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: textColor,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      );
                    }),
              ],
            ),
          ),
        )));
  }
}
