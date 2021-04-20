import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/ChatRoom.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/services/ChatHttpService.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/io.dart';

import '../models/ChatRoom.dart';

class ChatListingPage extends StatefulWidget {
  @override
  _ChatListingPageState createState() => _ChatListingPageState();
}

class _ChatListingPageState extends State<ChatListingPage> {
  final store = new FlutterSecureStorage();
  String username;
  bool loading = true;
  final chatService = ChatHttpService();

  List<ChatRoom> userList = [];
  @override
  void initState() {
    super.initState();
    resolveUsername();
  }

  void resolveUsername() async {
    var tmp = await store.read(key: "username");
    var chatListarr = await chatService.getChatRoomForUser(tmp);

    setState(() {
      username = tmp;
      userList = chatListarr;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Flexible(
              child: Text("Direct ",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w900)),
            ),
            Text("Message",
                style: GoogleFonts.inter(
                    color: kPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900)),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications_none_rounded),
              iconSize: 30,
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              }),
        ],
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  String otherUser = (userList[index].user1 == username)
                      ? userList[index].user2
                      : userList[index].user1;

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              "https://ui-avatars.com/api/?name=John+Doe"),
                        ),
                        title: Text(
                          otherUser,
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          var route = MaterialPageRoute(
                              builder: (context) => ChatView(
                                    chatID: userList[index].chatID,
                                    username: username,
                                    chatee: otherUser,
                                    channel: IOWebSocketChannel.connect(
                                        ("wss://chat.renteefy.ga/ws?username=" +
                                            username)),
                                  ));
                          Navigator.of(context).push(route);
                        }),
                  );
                },
              ),
            ),
    );
  }
}
