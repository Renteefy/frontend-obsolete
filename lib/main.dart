import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // const colour = const Color(0xfEF476f);
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      // body: TodayView(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              top: 100,
              left: 60,
              child: 
                Text("Welcome to",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)))),
          Positioned(
            top: 150,
            left: 60,
            child: Text("Renteefy",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color(0xffEF476f),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)))
            ),
          Positioned(
              child:
                  Image(image: NetworkImage("https://i.imgur.com/gNf5rxI.png")),
              width: 500,
              right: -63)
        ],
      ),
      // bottomSheet: Image(image: AssetImage("vector-creator.png")),
    ));
  }
}
