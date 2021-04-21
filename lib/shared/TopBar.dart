import 'package:badges/badges.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/GlobalState.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopBar extends PreferredSize {
  final List<String> title;

  TopBar(this.title);
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, GlobalState globalState, _) {
        return AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(title[0] + " ",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w900)),
              Text(title[1],
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900)),
            ],
          ),
          actions: [
            IconButton(
                icon: Badge(child: Icon(Icons.notifications_none_rounded)),
                iconSize: 30,
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                }),
            SizedBox(width: 10),
            IconButton(
                icon: Icon(Icons.messenger_outline),
                iconSize: 28,
                onPressed: () {
                  Navigator.pushNamed(context, '/chatListing');
                })
          ],
        );
      },
    );
  }
}
