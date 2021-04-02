import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  final NotificationListing notifi;

  const NotificationCard({this.notifi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Card(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Image.network(notifi.url)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(notifi.rentee,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: kAccentColor1,
                                fontWeight: FontWeight.bold)),
                        Text(" wants to rent",
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(notifi.title,
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                    ),
                    Text(notifi.status,
                        style: GoogleFonts.inter(
                            color: Color(0xffA0A0A0),
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kAccentColor1),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Accept this request",
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Reject this request",
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kAccentColor2),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Chat with owner",
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
            ),
          ),
        ],
      )),
    );
  }
}
