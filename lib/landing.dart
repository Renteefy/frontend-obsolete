import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './inputTextBox.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Welcome to",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
          Text("Renteefy",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffEF476f)))),
          SizedBox(height: 30),
          Text("Hey there,",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          Text("Join the private party",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 23, fontWeight: FontWeight.bold))),
          SizedBox(height: 50),
          WoInputWalaText(),
          SizedBox(height: 20),
          Container(
            child: Image.network(
              "https://i.imgur.com/gNf5rxI.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
