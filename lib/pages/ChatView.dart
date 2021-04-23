import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/ChatObj.dart';
import 'package:frontend/models/Message.dart';
import 'package:frontend/services/ChatHttpService.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatView extends StatefulWidget {
  final String chatID;
  final String username;
  final String chatee;
  final WebSocketChannel channel;
  const ChatView(
      {Key key, this.chatID, this.username, this.chatee, this.channel})
      : super(key: key);
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Message> chats = [];
  final chatService = ChatHttpService();
  @override
  void initState() {
    super.initState();
    () async {
      ChatObj chatobj = await chatService.getAllChats(widget.chatID);
      setState(() {
        chats = chatobj.messages;
        scrollController.animateTo(
            scrollController.position.maxScrollExtent + 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      });
    }();

    widget.channel.stream.listen((event) {
      setState(() {
        chats.add(Message.fromJson(jsonDecode(event)));
      });
    });
  }

  ScrollController scrollController = new ScrollController();
  TextEditingController messageController = new TextEditingController();

  void sendMessage(String message) {
    setState(() {
      chats.add(Message(
          chatID: widget.chatID,
          message: message,
          receiver: widget.chatee,
          sender: widget.username));
      scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut);
    });

    widget.channel.sink.add(jsonEncode({
      "chatID": widget.chatID,
      "message": message,
      "sender": widget.username,
      "receiver": widget.chatee,
      "action": "privateMessage"
    }));
  }

  @override
  Widget build(BuildContext context) {
    print(chats.length);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chatee), //Text(widget.chatee)
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(icon: Icon(Icons.info_outline_rounded), onPressed: () {})
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment:
                            (chats[index].sender == widget.username)
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: (chats[index].sender == widget.username)
                                  ? kPrimaryColor
                                  : kAccentColor3,
                            ),
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(chats[index].message,
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          (chats[index].time == null)
                              ? Text(DateFormat.Hm().format(DateTime.now()))
                              : Text(DateFormat.Hm().format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      int.parse(chats[index].time) * 1000))),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: messageController,
                onSubmitted: (value) {
                  sendMessage(value);
                  messageController.clear();
                },
                decoration: InputDecoration(
                    hintText: "message pls",
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        //print(messageController.text);
                        sendMessage(messageController.text);
                        messageController.clear();
                      },
                      icon: Icon(Icons.send_rounded),
                    )),
              )
            ],
          ),
        ));
  }
}
