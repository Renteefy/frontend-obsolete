import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey there,",
                          style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kAccentColor1)),
                      Text("Yajat Vishwakarma",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("yojat@gmail.com",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: kAccentColor3)),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      NetworkImage("https://ui-avatars.com/api/?name=John+Doe"),
                ),
              ],
            ),
          ],
        ));
  }
}
