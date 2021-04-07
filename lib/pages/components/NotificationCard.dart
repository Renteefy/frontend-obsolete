import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  final NotificationListing notifi;
  final bool isRentee;

  const NotificationCard({this.notifi, @required this.isRentee});

  @override
  Widget build(BuildContext context) {
    if (isRentee == true) {
      return Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifi.title,
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline_outlined,
                                size: 30,
                                color: Color(0xffd9d7d7),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rentee: " + notifi.rentee,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xffd9d7d7)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              (notifi.status == "Request Raised")
                                  ? Icon(
                                      Icons.warning_rounded,
                                      size: 30,
                                      color: Color(0xffd9d7d7),
                                    )
                                  : Icon(
                                      Icons.done_all_outlined,
                                      size: 30,
                                      color: Color(0xffd9d7d7),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Status: " + notifi.status,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xffd9d7d7)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        primary: Colors.transparent,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.messenger_outline_outlined),
                      label: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Chat with " + notifi.owner,
                          style: GoogleFonts.inter(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifi.title,
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline_outlined,
                                size: 30,
                                color: Color(0xffd9d7d7),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rentee: " + notifi.rentee,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xffd9d7d7)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              (notifi.status == "Request Raised")
                                  ? Icon(
                                      Icons.warning_rounded,
                                      size: 30,
                                      color: Color(0xffd9d7d7),
                                    )
                                  : Icon(
                                      Icons.warning_amber_outlined,
                                      size: 30,
                                      color: Color(0xffd9d7d7),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Status: " + notifi.status,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xffd9d7d7)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.check),
                        color: kAccentColor1,
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.close),
                        color: kPrimaryColor,
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.messenger_outline), onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
