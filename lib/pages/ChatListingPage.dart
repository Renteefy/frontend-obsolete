import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/ChatListing.dart';
import 'package:frontend/pages/ChatView.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListingPage extends StatelessWidget {
  final List<ChatListing> userList = [
    ChatListing.fromJson({
      "user1": {"username": "yajat"},
      "user2": {
        "username": "tester1",
        "lastMessage": "this is some last message"
      },
      "chatID": "this is chatID"
    }),
  ];

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
            var selUser = (userList[index].user1.username != "tester")
                ? userList[index].user1
                : userList[index]
                    .user2; // replace with username from global storage
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
                    userList[index].user1.username,
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: (selUser.lastMessage != null)
                      ? Text(selUser.lastMessage)
                      : Text('Start conversation'),
                  onTap: () {
                    var route = MaterialPageRoute(
                        builder: (context) =>
                            ChatView(chatID: userList[index].chatID));
                    Navigator.of(context).push(route);
                  }),
            );
          },
        ),
      ),
    );
  }
}
