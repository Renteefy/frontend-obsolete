import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/builders/NotificationCardBuilder.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Latest ",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        )),
                    Text("Notifications",
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: kPrimaryColor)),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                NotificationCardBuilder(
                  objarr: [
                    {
                      "url": "https://via.placeholder.com/150",
                      "title":
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,",
                      "rentee": "Ayush",
                      "status": "Request Raised",
                    },
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
