import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/ChatListing.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListingPage extends StatefulWidget {
  @override
  _ChatListingPageState createState() => _ChatListingPageState();
}

class _ChatListingPageState extends State<ChatListingPage> {
  final store = new FlutterSecureStorage();

  String username;

  final List<ChatListing> userList = [
    ChatListing.fromJson({
      "user1": "yajat",
      "user2": "tester1",
      "chatID": "this is chatID",
      "lastMessage": "this is lastmessage",
    }),
  ];
  @override
  void initState() {
    super.initState();
    resolveUsername();
  }

  void resolveUsername() async {
    var tmp = await store.read(key: "username");
    setState(() {
      username = tmp;
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
      body: Container(
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            String selUser = (userList[index].user1 != username)
                ? userList[index].user1
                : userList[index].user2;
            String unselUser = (userList[index].user1 == username)
                ? userList[index].user1
                : userList[index].user2;

            return Card(
              margin: EdgeInsets.all(20),
              child: ListTile(
                  trailing: Text("🟢"),
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                        "https://ui-avatars.com/api/?name=John+Doe"),
                  ),
                  title: Text(
                    selUser,
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: (userList[index].lastMessage != null)
                      ? Text(userList[index].lastMessage)
                      : Text('Start conversation'),
                  onTap: () {
                    var route = MaterialPageRoute(
                        builder: (context) => ChatView(
                              chatID: userList[index].chatId,
                              username: username,
                              chatee: unselUser,
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
