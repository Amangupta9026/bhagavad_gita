import 'dart:async';

import 'package:bard_api/bard_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/colors.dart';
import '../utils/utils.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  AiChatScreenState createState() => AiChatScreenState();
}

class AiChatScreenState extends State<AiChatScreen>
    with WidgetsBindingObserver {
  late ScrollController _scrollController;
  final TextEditingController _chatController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final chatRoomCollection = FirebaseFirestore.instance.collection('bard');
  final sessionCollection = FirebaseFirestore.instance.collection('session');
  String sessionId = "";
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool isProgressRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    chatRoomCollection.doc(FirebaseAuth.instance.currentUser?.phoneNumber).set({
      "name": _auth.currentUser?.displayName?.split(" ")[0] ?? "",
      "phone": _auth.currentUser?.phoneNumber ?? "",
      "photo_url": _auth.currentUser?.photoURL ?? "",
    });
    sessionCollection
        .doc("1")
        .get()
        .then((value) => sessionId = value["session"].first);
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  sendBardMessage(chatMessage) async {
    if (mounted) {
      setState(() {
        isProgressRunning = true;
      });
    }
    final bard = ChatBot(sessionId: sessionId);
    Map<String, dynamic>? result;
    try {
      result = await bard.ask(chatMessage);
    } catch (e) {
      await sessionCollection.doc("1").get().then((value) async {
        sessionId = value["session"][1];
        final bard = ChatBot(sessionId: sessionId);
        result = await bard.ask(chatMessage);
      });
    }

    Map<String, dynamic> messages2 = {
      "name": "AI Learning",
      "phone": "aibot@gmail.com",
      "photo_url":
          "https://png.pngtree.com/element_our/20200609/ourmid/pngtree-learning-machine-robot-image_2234559.jpg",
      "message": result?["content"],
      "time": FieldValue.serverTimestamp(),
    };
    await chatRoomCollection
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .collection('chats')
        .add(messages2);
    if (mounted) {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<void> onSendMessage() async {
    final chatMessage = _chatController.text.trim();
    _chatController.clear();

    Map<String, dynamic> messages = {
      "name": 'Anonymous',
      //_auth.currentUser?.displayName?.split(" ")[0] ?? "",
      "phone": _auth.currentUser?.phoneNumber ?? "",
      "photo_url": _auth.currentUser?.photoURL ?? "",
      "message": chatMessage,
      "time": FieldValue.serverTimestamp(),
    };
    await chatRoomCollection
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .collection('chats')
        .add(messages);
    sendBardMessage(chatMessage);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text('Ask me anything !',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        height: double.infinity,
        decoration: AppUtils.decoration1(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: chatRoomCollection
                              .doc(FirebaseAuth
                                  .instance.currentUser?.phoneNumber)
                              .collection('chats')
                              .orderBy('time', descending: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data?.docs.isEmpty ?? true) {
                                return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/ai_learning.webp",
                                        height: 200,
                                        width: 200,
                                      ),
                                      const Text(
                                        "Hey there!, Glad to see you, Let's start your learning journey. Ask me anything!",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Expanded(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final chatData =
                                          snapshot.data?.docs[index];
                                      return Container(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width * 0.7),
                                        alignment: chatData?['phone'] ==
                                                _auth.currentUser?.phoneNumber
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal: 10,
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: const Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    chatData?['phone'] ==
                                                            _auth.currentUser
                                                                ?.phoneNumber
                                                        ? CrossAxisAlignment.end
                                                        : CrossAxisAlignment
                                                            .start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      if (chatData?['phone'] ==
                                                              _auth.currentUser
                                                                  ?.phoneNumber &&
                                                          chatData?[
                                                                  'photo_url'] ==
                                                              null) ...{
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: chatData?[
                                                                          'phone'] ==
                                                                      _auth
                                                                          .currentUser
                                                                          ?.phoneNumber
                                                                  ? NetworkImage(
                                                                      chatData?[
                                                                              'photo_url'] ??
                                                                          "",
                                                                    )
                                                                  : Image.asset(
                                                                      "assets/images/ai_learning.webp",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ).image,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            border: Border.all(
                                                              color:
                                                                  primaryColor,
                                                              width: 1,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      } else if (chatData?[
                                                              'phone'] ==
                                                          _auth.currentUser
                                                              ?.phoneNumber) ...{
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  primaryColor,
                                                              width: 1,
                                                            ),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: RandomAvatar(
                                                            FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.phoneNumber ??
                                                                "xyz",
                                                          ),
                                                        ),
                                                      } else ...{
                                                        Image.asset(
                                                            "assets/images/ai_learning.webp",
                                                            height: 40,
                                                            width: 40)
                                                      },
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        chatData?['name'] ?? "",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                    ),
                                                    child: Text(
                                                      chatData?['message'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                        fontFamily: GoogleFonts
                                                                .robotoFlex()
                                                            .fontFamily,
                                                      ),
                                                      textAlign: chatData?[
                                                                  'phone'] ==
                                                              _auth.currentUser
                                                                  ?.phoneNumber
                                                          ? TextAlign.right
                                                          : TextAlign.left,
                                                    ),
                                                  ),
                                                  Text(
                                                    timeago.format(
                                                      chatData?['time'] == null
                                                          ? DateTime.now()
                                                          : chatData?['time']
                                                              .toDate(),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10.0,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      isProgressRunning
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: Image.asset(
                                      "assets/images/ai_learning.webp",
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                                  const Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Card(
                                        color: darkBlueColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Searching for answers...",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  width: size.width,
                  alignment: Alignment.center,
                  child: TextFormField(
                    autofocus: false,
                    controller: _chatController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            if (_chatController.text.trim().isNotEmpty) {
                              onSendMessage();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.send),
                          )),
                      hintText: 'Type here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              // }
            ],
          ),
        ),
      ),
    );
  }
}
