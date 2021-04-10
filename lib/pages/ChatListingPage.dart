import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/ChatListing.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListingPage extends StatelessWidget {
  final List<ChatListing> usersList = [
    ChatListing(chatID: "chat1", user1: "tester1", user2: "yajat"),
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
          itemCount: usersList.length,
          itemBuilder: (context, index) {
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
                    "Ayush",
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('The airplane is only in Act II.'),
                  onTap: () => print("ListTile")),
            );
          },
        ),
      ),
    );
  }
}
