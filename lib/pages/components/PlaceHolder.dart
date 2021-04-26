import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceholderHorizontalView extends StatelessWidget {
  const PlaceholderHorizontalView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175.0,
              width: 175.0,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "look",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175.0,
              width: 175.0,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "into the",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175.0,
              width: 175.0,
              color: Colors.white10,
              child: Center(
                  child: Text(
                "void",
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white24),
              )),
            ),
          )
        ],
      ),
    );
  }
}
