import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  final String chatID;
  final String username;
  const ChatView({Key key, this.chatID, this.username}) : super(key: key);
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List chats = [];

  @override
  void initState() {
    super.initState();
    chats.add({"sender": "yajat", "message": "value", "time": DateTime.now()});
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = new ScrollController();
    TextEditingController messageController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment:
                            (chats[index]["sender"] == widget.username)
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: (chats[index]["sender"] != widget.username)
                                  ? kPrimaryColor
                                  : kAccentColor3,
                            ),
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(chats[index]["message"],
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Text(DateFormat.Hm().format(chats[index]["time"])),
                        ],
                      );
                    })),
            TextField(
              controller: messageController,
              onSubmitted: (value) {
                setState(() {
                  chats.add({
                    "sender": "yajat",
                    "message": value,
                    "time": DateTime.now()
                  });
                  messageController.clear();
                });
              },
              onChanged: (val) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                filled: true,
                border: InputBorder.none,
                hintText: 'Start typing here...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
