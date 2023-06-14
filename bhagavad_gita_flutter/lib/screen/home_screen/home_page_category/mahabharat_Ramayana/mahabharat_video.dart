// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../../utils/file_collection.dart';




// class CourseDetails extends StatelessWidget {
//   final String courseId;
//   CourseDetails({required this.courseId, super.key});

//   final yt = YoutubeExplode();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorGradient2,
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(40),
//           child: HeaderWidget(
//             text1: 'Course Details',
//             isCenterTitle: true,
//             leading1: Icons.arrow_back,
           
//           )),
      
//       body: Container(
//         decoration: AppUtils.decoration1(),
//         height: double.infinity,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 60),
//               child: StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection("course")
//                       .doc(courseId)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     final data = snapshot.data?.data();
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: TextWidget(
//                                 text1: data?["course_name"] ?? "",
//                                 color1: colortext,
//                                 size1: 20.0,
//                                 fontWeight1: FontWeight.bold,
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Share.share(
//                                     'hey! check out this learning app https://play.google.com/store/apps/details?id=com.learning.qwise&hl=en_IN&gl=US');
//                               },
//                               child: const Icon(Icons.share),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 20.0),
//                         Container(
//                           padding: const EdgeInsets.only(bottom: 13),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: const [
//                               BoxShadow(color: Colors.grey, blurRadius: 10)
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(10.0, 12, 10, 0),
//                             child: Column(
//                               children: [
//                                 if (data?["image"] != null) ...{
//                                   Image.network(data?["image"] ?? ""),
//                                 } else ...{
//                                   Image.asset(
//                                     'assets/images/course1.png',
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 },
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30.0),
//                         const TextWidget(
//                           text1: 'Course Description',
//                           color1: colortext,
//                           size1: 20.0,
//                           fontWeight1: FontWeight.bold,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextWidget(
//                           text1:
//                               '${data?['course_name']} is an rapidly growing area in high demand. Statistics play a key role in the process of making sound business decisions that will generate higher profits. Without statistics, it\'s difficult to determine what your target audience wants and needs. ',
//                           color1: colortext,
//                           size1: 15.0,
//                         ),
//                         const SizedBox(height: 20.0),
//                         const TextWidget(
//                           text1: 'Course Content',
//                           color1: colortext,
//                           size1: 20.0,
//                           fontWeight1: FontWeight.bold,
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextWidget(
//                           text1: "${data?['course_name']} ",
//                           color1: colortext,
//                           size1: 15.0,
//                         ),

//                         const SizedBox(height: 20.0),
//                         //Learn More

//                         Consumer<CourseDetailsNotifier>(
//                             builder: (context, ref, child) {
//                           return Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   ref.showMore();
//                                 },
//                                 child: Row(children: [
//                                   TextWidget(
//                                     text1: !ref.isShowMore
//                                         ? 'Show More'
//                                         : 'Show Less',
//                                     color1: Colors.black,
//                                     size1: 15.0,
//                                     fontWeight1: FontWeight.bold,
//                                   ),
//                                   const SizedBox(width: 5.0),
//                                   ref.isShowMore
//                                       ? const Icon(MdiIcons.arrowDown)
//                                       : const Icon(MdiIcons.arrowUp),
//                                 ]),
//                               ),
//                               const SizedBox(height: 14.0),
//                               ref.isShowMore
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const TextWidget(
//                                           text1: "What you'll learn",
//                                           color1: colortext,
//                                           size1: 20.0,
//                                           fontWeight1: FontWeight.bold,
//                                         ),
//                                         const SizedBox(height: 10.0),
//                                         TextWidget(
//                                           text1:
//                                               "In this course about '${data?['course_name']}' you will gain proficiency how to analyze a number of statistical knowledge enhance. You will learn how to master in ${data?['course_name']} from beginning to advance pro level. The output/result you will get after completed this course ${data?['course_name']}. Its number of different statistical tests Learning about beginner to advance of statistical analyses using this app guidelines",
//                                           color1: colortext,
//                                           size1: 15.0,
//                                         ),
//                                         const SizedBox(height: 10.0),
//                                         const TextWidget(
//                                           text1: "Requirements",
//                                           color1: colortext,
//                                           size1: 20.0,
//                                           fontWeight1: FontWeight.bold,
//                                         ),
//                                         const SizedBox(height: 10.0),
//                                         const TextWidget(
//                                           text1:
//                                               "Laptop or PC with Internet Connection and a Browser (Chrome, Safari, Firefox, etc.), No prior knowledge is required, You will learn from basic concept\n\n",
//                                           color1: colortext,
//                                           size1: 15.0,
//                                         ),
//                                       ],
//                                     )
//                                   : const SizedBox(),
//                             ],
//                           );
//                         }),
//                       ],
//                     );
//                   }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
