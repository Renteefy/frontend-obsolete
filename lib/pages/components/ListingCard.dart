import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ListingCard extends StatelessWidget {
  final String url;
  final String title;
  final String price;
  final String interval;
  final int flex;
  ListingCard(
      {this.url = "https://via.placeholder.com/150",
      @required this.title,
      @required this.price,
      @required this.interval,
      this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      url,
                      width: 151,
                      height: 162,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("$title",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("₹" + price,
                          style: GoogleFonts.inter(
                              color: kAccentColor2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text(" " + interval,
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kAccentColor2),
                      onPressed: () {},
                      child: Center(child: Text("Rent this"))),
                ],
              ),
            ),
          )),
    );
  }
}
